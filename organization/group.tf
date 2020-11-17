resource "gsuite_group" "prj_kon_d_admin_group" {
  email       = "group-${local.prj_kon_d_name}@${var.domain}"
  name        = "group-${local.prj_kon_d_name}@${var.domain}"
  description = "Admin group for project ${local.prj_kon_d_name}"
}

resource "gsuite_group" "prj_kon_d_app_admin_group" {
  email       = "group-${local.prj_kon_d_app_name}@${var.domain}"
  name        = "group-${local.prj_kon_d_app_name}@${var.domain}"
  description = "Admin groug for project ${local.prj_kon_d_app_name}"
}
