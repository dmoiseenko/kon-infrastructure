resource "google_organization_iam_binding" "project_creator" {
  org_id = var.org_id
  role   = "roles/resourcemanager.projectCreator"
  members = [
    "group:${var.group_org_admin}",
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}
