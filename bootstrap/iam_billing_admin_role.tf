resource "google_organization_iam_binding" "billing_admin" {
  org_id = var.org_id
  role   = "roles/billing.admin"
  members = [
    "group:${var.group_billing_admin}",
  ]
}