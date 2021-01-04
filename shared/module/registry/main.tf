module "project" {
  source = "git@github.com:dmoiseenko/kon-infrastructure.git//environment/development/module/gcp/project?ref=v0.0.8"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  service_account_roles    = []
  development_group_roles  = []
  activate_apis = [
    "artifactregistry.googleapis.com",
  ]
}

resource "google_artifact_registry_repository" "kon" {
  provider = google-beta

  project       = module.project.project_id
  location      = var.registry_location
  repository_id = var.registry_name
  format        = "DOCKER"

  depends_on = [
    module.project
  ]
}

resource "gsuite_group" "writer" {
  email       = "grp-writer-${module.project.project_id}@${var.organization_domain_name}"
  name        = "grp-writer-${module.project.project_id}@${var.organization_domain_name}"
  description = "Registry ${google_artifact_registry_repository.kon.id} writer group"
}

resource "gsuite_group" "reader" {
  email       = "grp-reader-${module.project.project_id}@${var.organization_domain_name}"
  name        = "grp-reader-${module.project.project_id}@${var.organization_domain_name}"
  description = "Registry ${google_artifact_registry_repository.kon.id} reader group"
}

resource "google_artifact_registry_repository_iam_member" "writer_group" {
  provider = google-beta

  location   = google_artifact_registry_repository.kon.location
  repository = google_artifact_registry_repository.kon.name
  project    = module.project.project_id
  role       = "roles/artifactregistry.writer"
  member     = "group:${gsuite_group.writer.email}"
}

resource "google_artifact_registry_repository_iam_member" "reader_group" {
  provider = google-beta

  location   = google_artifact_registry_repository.kon.location
  repository = google_artifact_registry_repository.kon.name
  project    = module.project.project_id
  role       = "roles/artifactregistry.reader"
  member     = "group:${gsuite_group.reader.email}"
}

resource "google_artifact_registry_repository_iam_member" "iam_repo_kon_all_users" {
  provider = google-beta

  location   = google_artifact_registry_repository.kon.location
  repository = google_artifact_registry_repository.kon.name
  project    = module.project.project_id
  role       = "roles/artifactregistry.reader"
  member     = "allUsers"
}
