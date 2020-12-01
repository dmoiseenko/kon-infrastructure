resource "gsuite_group_member" "group_gke_security" {
  group = var.group_gke_security
  email = var.group_gke_admin
  role  = "MEMBER"
}
