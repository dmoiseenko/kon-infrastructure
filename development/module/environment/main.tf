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
  network_name     = var.network_name
  subnets          = var.vpc_subnets
  secondary_ranges = var.vpc_secondary_ranges

  depends_on = [module.host_project]
}
