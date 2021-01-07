module "host_project" {
  source = "../gcp/project"

  project_name             = var.host_project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  development_group_roles  = []
  admin_group_roles        = []
  service_account_roles    = []
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}

module "app_project" {
  source = "../gcp/project"

  project_name             = var.app_project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  development_group_roles  = []
  admin_group_roles = [
    "roles/iap.admin"
  ]
  service_account_roles = []
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "iap.googleapis.com",
    "cloudkms.googleapis.com",
  ]
}

module "dns" {
  source = "../gcp/dns"

  project_name             = var.dns_project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  domain_name              = var.domain_name
  subdomain                = var.subdomain
}

module "secret" {
  source = "../gcp/secret"

  project_name             = var.secret_project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "3.0.0"

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

  host_project_id = module.host_project.project_id

  depends_on = [
    module.host_project,
    module.vpc,
  ]
}

module "shared_vpc_service" {
  source = "../gcp/shared_vpc_service"

  service_project_id        = module.app_project.project_id
  service_project_number    = module.app_project.project_number
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

# module "gke" {
#   source = "../gcp/gke"

#   project_id                     = module.app_project.project_id
#   domain_name                    = var.domain_name
#   cluster_name                   = var.gke_name
#   release_channel                = var.gke_release_channel
#   network_self_link              = module.vpc.network_self_link
#   subnetwork_self_link           = module.vpc.subnets_self_links[0]
#   pods_ip_range_name             = module.vpc.subnets_secondary_ranges[0][1].range_name
#   services_ip_range_name         = module.vpc.subnets_secondary_ranges[0][0].range_name
#   service_account_email          = module.app_project.service_account_email
#   service_account_name           = module.app_project.service_account_name
#   location                       = var.gke_location
#   is_preemptible_node            = var.gke_is_preemptible_node
#   machine_type                   = var.gke_machine_type
#   min_node_count                 = var.gke_min_node_count
#   max_node_count                 = var.gke_max_node_count
#   dns_project_id                 = module.dns.project_id
#   dns_admin_service_account_name = module.dns.dns_admin_service_account_name
#   vault_service_account_name     = module.secret.vault_service_account_name

#   depends_on = [
#     module.shared_vpc_service,
#   ]
# }

module "firewall" {
  source = "../gcp/firewall"

  project_id                   = module.host_project.project_id
  network_name                 = var.vpc_network_name
  target_service_account_email = module.app_project.service_account_email

  depends_on = [
    module.vpc,
  ]
}

module "iap" {
  source = "../gcp/iap"

  project_id                      = module.app_project.project_id
  domain_name                     = var.domain_name
  terraform_service_account_email = var.terraform_service_account_email

  depends_on = [
    module.app_project,
  ]
}
