module "host_project" {
  source = "../gcp/project"

  project_name       = var.host_project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  domain_name        = var.domain_name
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}

module "app_project" {
  source = "../gcp/project"

  project_name       = var.app_project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  domain_name        = var.domain_name
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "iamcredentials.googleapis.com",
    "iap.googleapis.com",
  ]
}

module "dns" {
  source = "../gcp/dns"

  project_name       = var.dns_project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  domain_name        = var.domain_name
  dns_name           = var.dns_name
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "2.6.0"

  project_id       = module.host_project.project_id
  network_name     = var.vpc_network_name
  subnets          = var.vpc_subnets
  secondary_ranges = var.vpc_secondary_ranges

  depends_on = [
    module.host_project
  ]
}

module "shared_vpc_host" {
  source = "../gcp/shared_vpc_host"

  project_id = module.host_project.project_id

  depends_on = [
    module.host_project,
    module.vpc,
  ]
}

module "shared_vpc_service" {
  source = "../gcp/shared_vpc_service"

  project_id                = module.app_project.project_id
  project_number            = module.app_project.project_number
  vpc_host_project_id       = module.host_project.project_id
  shared_vpc_subnet_names   = [module.vpc.subnets_names[0]]
  shared_vpc_subnet_regions = [module.vpc.subnets_regions[0]]
  service_account_email     = module.app_project.service_account_email

  depends_on = [
    module.host_project,
    module.app_project,
    module.vpc,
    module.shared_vpc_host,
  ]
}

module "gke" {
  source = "../gcp/gke"

  project_id                     = module.app_project.project_id
  domain_name                    = var.domain_name
  cluster_name                   = var.gke_name
  network_self_link              = module.vpc.network_self_link
  subnetwork_self_link           = module.vpc.subnets_self_links[0]
  pods_ip_range_name             = module.vpc.subnets_secondary_ranges[0][1].range_name
  services_ip_range_name         = module.vpc.subnets_secondary_ranges[0][0].range_name
  default_service_account_email  = module.app_project.service_account_email
  location                       = var.gke_location
  is_preemptible_node            = var.gke_is_preemptible_node
  machine_type                   = var.gke_machine_type
  min_node_count                 = var.gke_min_node_count
  max_node_count                 = var.gke_max_node_count
  project_id_dns                 = module.dns.project_id
  service_account_name_dns_admin = module.dns.service_account_name_dns_admin

  depends_on = [
    module.shared_vpc_service,
  ]
}

resource "google_compute_firewall" "default" {
  name    = "gke-load-balancer"
  network = module.vpc.network_name
  project = module.host_project.project_id

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_service_accounts = [module.app_project.service_account_email]
}

resource "gsuite_group" "group_iap_support" {
  email       = "support-${module.app_project.project_id}@${var.domain_name}"
  name        = "support-${module.app_project.project_id}@${var.domain_name}"
  description = "Support group for IAP in ${module.app_project.project_id}"
}

# https://github.com/hashicorp/terraform-provider-google/issues/6104
resource "gsuite_group_member" "support_owner" {
  group = gsuite_group.group_iap_support.email
  email = var.terraform_service_account_email
  role  = "OWNER"
}

resource "google_iap_brand" "kon" {
  support_email     = gsuite_group.group_iap_support.email
  application_title = "kon"
  project           = module.app_project.project_id

  depends_on = [
    module.app_project,
    gsuite_group_member.support_owner
  ]
}

resource "google_iap_client" "project_client" {
  display_name = "kon client"
  brand        = google_iap_brand.kon.name
}

resource "google_iap_web_iam_member" "member" {
  project = module.app_project.project_id
  role    = "roles/iap.httpsResourceAccessor"
  member  = "domain:${var.domain_name}"

  depends_on = ["google_iap_brand.kon"]
}
