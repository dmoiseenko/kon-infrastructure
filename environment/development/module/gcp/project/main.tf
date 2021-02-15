resource "google_project" "main" {
  name                = var.project_name
  project_id          = "${var.project_name}-${random_id.random_project_id_suffix.hex}"
  folder_id           = var.folder_id
  billing_account     = var.billing_account_id
  auto_create_network = false
}

resource "google_project_service" "project_services" {
  count = length(var.activate_apis)

  project = google_project.main.project_id
  service = var.activate_apis[count.index]

  disable_dependent_services = true
}

resource "google_project_default_service_accounts" "main" {
  project = google_project.main.project_id
  action  = "DELETE"

  depends_on = [
    google_project_service.project_services,
  ]
}

resource "google_service_account" "main" {
  account_id   = "sa-main"
  display_name = "${var.project_name} Project Service Account"
  project      = google_project.main.project_id
}

resource "google_project_iam_member" "main_service_account_roles" {
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

resource "google_project_iam_member" "admin_group_roles" {
  count = length(var.admin_group_roles)

  member  = "group:${gsuite_group.admin.email}"
  project = google_project.main.project_id
  role    = var.admin_group_roles[count.index]
}

resource "gsuite_group" "development" {
  email       = "grp-dev-${google_project.main.project_id}@${var.organization_domain_name}"
  name        = "grp-dev-${google_project.main.project_id}@${var.organization_domain_name}"
  description = "Development group for project ${google_project.main.project_id}"
}

resource "google_project_iam_member" "development_group_roles" {
  count = length(var.development_group_roles)

  member  = "group:${gsuite_group.development.email}"
  project = google_project.main.project_id
  role    = var.development_group_roles[count.index]
}
