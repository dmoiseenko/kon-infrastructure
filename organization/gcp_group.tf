resource "gsuite_group" "host_project_name_development_admin_group" {
  email       = "group-admin-${local.host_project_name_development}@${var.domain}"
  name        = "group-admin-${local.host_project_name_development}@${var.domain}"
  description = "Admin group for project ${local.host_project_name_development}"
}

resource "gsuite_group" "app_project_name_development_admin_group" {
  email       = "group-admin-${local.app_project_name_development}@${var.domain}"
  name        = "group-admin-${local.app_project_name_development}@${var.domain}"
  description = "Admin groug for project ${local.app_project_name_development}"
}
