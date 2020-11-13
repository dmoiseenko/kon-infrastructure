locals {
  proj_kon_d_activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
  prj_kon_d_default_service_account_roles = []
  prj_kon_d_app_activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
  prj_kon_d_app_default_service_account_roles = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
  ]
}

data "terraform_remote_state" "group_kon_d" {
  backend = "remote"

  config = {
    organization = "dmoiseenko"
    workspaces = {
      name = "group_kon_d"
    }
  }
}

module "prj_kon_d" {
  source = "../../module/project"

  project_name                  = local.prj_kon_d_name
  billing_account               = var.billing_account
  folder_id                     = google_folder.kon_dev.id
  admin_group_email             = gsuite_group.prj_kon_d_admin_group.email
  activate_apis                 = local.proj_kon_d_activate_apis
  default_service_account_roles = local.prj_kon_d_default_service_account_roles
  
}

# resource "aws_instance" "foo" {
#   subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
# }