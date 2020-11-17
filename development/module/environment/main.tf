module "host_project" {
  source = "../gcp_project"

  project_name       = var.host_project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}

module "app_project" {
  source = "../gcp_project"

  project_name       = var.app_project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "2.5.0"

  project_id       = module.host_project.project_id
  network_name     = var.vpc_network_name
  subnets          = var.vpc_subnets
  secondary_ranges = var.vpc_secondary_ranges

  depends_on = [module.host_project]
}

module "shared_vpc_host" {
  source = "../shared_vpc_host"

  project_id = module.host_project.project_id

  depends_on = [
    module.host_project
  ]
}

module "shared_vpc_service" {
  source = "../shared_vpc_service"

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
  source = "../gke"

  cluster_name                  = var.gke_name
  project_id                    = module.app_project.project_id
  network_self_link             = module.vpc.network_self_link
  subnetwork_self_link          = module.vpc.subnets_self_links[0]
  pods_ip_range_name            = module.vpc.subnets_secondary_ranges[0][1].range_name
  services_ip_range_name        = module.vpc.subnets_secondary_ranges[0][0].range_name
  default_service_account_email = module.app_project.service_account_email
  location                      = var.gke_location
  is_preemptible_node           = var.gke_is_preemptible_node
  machine_type                  = var.gke_machine_type
  min_node_count                = var.gke_min_node_count
  max_node_count                = var.gke_max_node_count

  depends_on = [
    module.shared_vpc_service,
  ]
}
