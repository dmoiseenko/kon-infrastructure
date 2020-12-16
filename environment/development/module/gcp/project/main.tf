resource "google_project" "main" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_id.random_project_id_suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account_id
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

resource "google_service_account" "service_account" {
  account_id   = "project-service-account"
  display_name = "${var.project_name} Project Service Account"
  project      = google_project.main.project_id
}

resource "gsuite_group" "group_admin" {
  email       = "group-admin-${google_project.main.project_id}@${var.domain_name}"
  name        = "group-admin-${google_project.main.project_id}@${var.domain_name}"
  description = "Admin group for project ${google_project.main.project_id}"
}

resource "google_project_iam_member" "host_project_admin_group_role" {
  member  = "group:${gsuite_group.group_admin.email}"
  project = google_project.main.project_id
  role    = "roles/editor"
}

resource "gsuite_group" "group_dev" {
  email       = "group-dev-${google_project.main.project_id}@${var.domain_name}"
  name        = "group-dev-${google_project.main.project_id}@${var.domain_name}"
  description = "Development group for project ${google_project.main.project_id}"
}
