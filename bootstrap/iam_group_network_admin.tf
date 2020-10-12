resource "google_organization_iam_member" "xpn_admin" {
  org_id = var.org_id
  role   = "roles/compute.xpnAdmin"
  member = "group:${var.group_network_admin}"
}
