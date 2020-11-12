locals {

}

module "project" {
  source = "./module/environment/project"

  host_project_name  = "aasdasdasd"
  app_project_name   = "basddffff"
  billing_account_id = var.billing_account_id
  folder_id          = "937516052901"
}
