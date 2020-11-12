# locals {
#   build_project_name    = "prj-kon-sh-build"
# }

# resource "gsuite_group" "build_project_name_admin_group" {
#   email       = "group_${local.build_project_name}@${var.domain}"
#   name        = "group_${local.build_project_name}@${var.domain}"
#   description = "Controlling groug for project ${local.build_project_name}"
# }

# module "project" {
#   source = "./module/project"

#   project_name      = local.build_project_name
#   billing_account   = var.billing_account
#   folder_id         = google_folder.shared.id
#   admin_group_email = gsuite_group.build_project_name_admin_group.email
# }
