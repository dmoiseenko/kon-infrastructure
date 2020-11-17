resource "google_organization_iam_binding" "organization_admin" {
  org_id = var.org_id
  role   = "roles/resourcemanager.organizationAdmin"
  members = [
    "group:${var.group_org_admin}",
  ]
}
