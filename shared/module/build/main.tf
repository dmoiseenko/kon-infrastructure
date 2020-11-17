resource "google_project" "main" {
  name            = var.project_build_name
  project_id      = "${var.project_build_name}-${random_id.random_project_id_suffix.hex}"
  folder_id       = var.folder_shared_id
  billing_account = var.billing_account_id
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "4.0.0"

  project_id = google_project.main.project_id
  activate_apis = [
    "cloudbuild.googleapis.com",
    "containerregistry.googleapis.com",
    "artifactregistry.googleapis.com",
  ]

  depends_on = [
    google_project.main,
  ]
}

resource "google_service_account" "ci_service_account" {
  account_id   = "ci-service-account"
  display_name = "${var.project_build_name} CI Service Account"
  project      = google_project.main.project_id
}

module "iam_ci_service_account" {
  source  = "terraform-google-modules/iam/google//modules/member_iam"
  version = "6.3.1"

  service_account_address = google_service_account.ci_service_account.email
  prefix                  = "serviceAccount"
  project_id              = google_project.main.project_id
  project_roles = [
    "roles/cloudbuild.builds.builder",
    "roles/storage.objectViewer",
  ]
}

resource "google_storage_bucket" "bucket_project_id" {
  name    = google_project.main.project_id
  project = google_project.main.project_id
}

resource "google_project_iam_member" "group_admin_project_build_shared_email" {
  member  = "group:${var.group_admin_project_build_shared_email}"
  project = google_project.main.project_id
  role    = "roles/editor"
}

resource "google_artifact_registry_repository" "repo_kon" {
  provider = google-beta

  project       = google_project.main.project_id
  location      = "us-east1"
  repository_id = "repo-kon"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "iam_repo_kon_ci_service_account" {
  provider = google-beta

  location   = google_artifact_registry_repository.repo_kon.location
  repository = google_artifact_registry_repository.repo_kon.name
  project    = google_project.main.project_id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.ci_service_account.email}"
}
