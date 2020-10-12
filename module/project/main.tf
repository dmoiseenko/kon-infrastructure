resource "google_project" "main" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_id.random_project_id_suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "4.0.0"

  project_id = google_project.main.project_id
  activate_apis = var.activate_apis

  depends_on = [
    google_project.main,
  ]
}

resource "google_project_default_service_accounts" "main" {
  project = google_project.main.project_id
  action  = "DELETE"

  depends_on = [
    module.project_services,
  ]
}

resource "google_service_account" "default_service_account" {
  account_id   = "project-service-account"
  display_name = "${var.project_name} Project Service Account"
  project      = google_project.main.project_id
}

resource "google_project_iam_member" "default_service_account" {
  count = length(var.default_service_account_roles)

  project = google_project.main.project_id
  role    = var.default_service_account_roles[count.index]
  member  = "serviceAccount:${google_service_account.default_service_account.email}"
}

resource "google_project_iam_member" "gsuite_group_role" {
  member  = "group:${var.admin_group_email}"
  project = google_project.main.project_id
  role    = "roles/editor"

  depends_on = [
    module.project_services,
  ]
}

resource "google_service_account_iam_member" "default_service_account_grant_to_group" {
  member             = "group:${var.admin_group_email}"
  role               = "roles/iam.serviceAccountUser"
  service_account_id = google_service_account.default_service_account.id

  depends_on = [
    google_project_default_service_accounts.main,
  ]
}
