module "build" {
  source = "./module/build"

  project_build_name                     = var.project_build_name
  folder_shared_id                       = var.folder_shared_id
  billing_account_id                     = var.billing_account_id
  group_admin_project_build_shared_email = var.group_admin_project_build_shared_email
}
