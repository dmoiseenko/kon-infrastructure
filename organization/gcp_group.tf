resource "gsuite_group" "group_admin_project_build_shared" {
  email       = "group-admin-${local.project_build_name}@${var.domain}"
  name        = "group-admin-${local.project_build_name}@${var.domain}"
  description = "Admin groug for project ${local.project_build_name}"
}
