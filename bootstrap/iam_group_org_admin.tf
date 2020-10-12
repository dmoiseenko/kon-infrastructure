resource "google_organization_iam_member" "policy_admin" {
  org_id = var.org_id
  role   = "roles/orgpolicy.policyAdmin"
  member = "group:${var.group_org_admin}"
}
