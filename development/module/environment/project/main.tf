module "host_project" {
  source = "../../common/gcp_project"

  project_name    = var.host_project_name
  billing_account_id = var.billing_account_id
  folder_id       = var.folder_id
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}

module "app_project" {
  source = "../../common/gcp_project"

  project_name    = var.app_project_name
  billing_account_id = var.billing_account_id
  folder_id       = var.folder_id
  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
}
