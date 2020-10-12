resource "gsuite_group" "prj_kon_d_admin_group" {
  email       = "group-${var.prj_kon_d_name}@${var.domain}"
  name        = "group-${var.prj_kon_d_name}@${var.domain}"
  description = "Admin group for project ${var.prj_kon_d_name}"
}
