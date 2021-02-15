resource "google_organization_iam_binding" "billing_creator" {
  org_id = var.org_id
  role   = "roles/billing.creator"
  members = [
    "group:${var.group_billing_admin}",
  ]
}
