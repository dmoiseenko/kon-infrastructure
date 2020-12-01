locals {
  host_project_name = "prj-kon-d"
  app_project_name  = "prj-kon-app-d"
  gke_name          = "gke-d-app"
  gke_location      = "us-east1-b"
}

data "google_client_config" "provider" {}

module "development" {
  source = "./module/environment"

  domain_name = var.domain_name

  host_project_name  = local.host_project_name
  app_project_name   = local.app_project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id

  vpc_network_name = "vpc-kon"
  vpc_subnets = [
    {
      subnet_name           = "tier-1"
      subnet_ip             = "11.0.4.0/22"
      subnet_region         = "us-east1"
      subnet_private_access = "true"
    },
  ]
  vpc_secondary_ranges = {
    tier-1 = [
      {
        range_name    = "tier-1-services"
        ip_cidr_range = "11.0.32.0/20"
      },
      {

        range_name    = "tier-1-pods"
        ip_cidr_range = "11.4.0.0/14"
      },
    ]
  }

  gke_name                = local.gke_name
  gke_location            = local.gke_location
  gke_is_preemptible_node = true
  gke_machine_type        = "e2-standard-2"
  gke_min_node_count      = 3
  gke_max_node_count      = 4
}
