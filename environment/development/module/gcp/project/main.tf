resource "google_project" "main" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_id.random_project_id_suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account_id
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "4.0.0"

  project_id    = google_project.main.project_id
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

resource "google_service_account" "main" {
  account_id   = "sa"
  display_name = "${var.project_name} Project Service Account"
  project      = google_project.main.project_id
}

resource "google_project_iam_member" "main_service_account_role" {
  count = length(var.service_account_roles)

  member  = "serviceAccount:${google_service_account.main.email}"
  project = google_project.main.project_id
  role    = var.service_account_roles[count.index]
}

resource "gsuite_group" "admin" {
  email       = "grp-admin-${google_project.main.project_id}@${var.organization_domain_name}"
  name        = "grp-admin-${google_project.main.project_id}@${var.organization_domain_name}"
  description = "Admin group for project ${google_project.main.project_id}"
}

resource "google_project_iam_member" "admin_group_editor_role" {
  member  = "group:${gsuite_group.admin.email}"
  project = google_project.main.project_id
  role    = "roles/editor"
}

resource "gsuite_group" "dev" {
  email       = "grp-dev-${google_project.main.project_id}@${var.organization_domain_name}"
  name        = "grp-dev-${google_project.main.project_id}@${var.organization_domain_name}"
  description = "Development group for project ${google_project.main.project_id}"
}

resource "google_project_iam_member" "dev_group_role" {
  count = length(var.development_group_roles)

  member  = "group:${gsuite_group.dev.email}"
  project = google_project.main.project_id
  role    = var.development_group_roles[count.index]
}
