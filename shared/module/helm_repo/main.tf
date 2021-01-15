module "project" {
  source = "git@github.com:dmoiseenko/kon-infrastructure.git//environment/development/module/gcp/project?ref=v0.0.9"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  service_account_roles    = []
  development_group_roles  = []
  activate_apis = [
    "storage-api.googleapis.com",
  ]
}

resource "google_storage_bucket" "helm_repo" {
  name                        = "${module.project.project_id}-helm"
  project                     = module.project.project_id
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

# TODO: Disallow unauthorized access
resource "google_storage_bucket_iam_member" "allUsers_object_viewer" {
  bucket = google_storage_bucket.helm_repo.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "gsuite_group" "writer" {
  email       = "grp-helm-writer-${module.project.project_id}@${var.organization_domain_name}"
  name        = "grp-helm-writer-${module.project.project_id}@${var.organization_domain_name}"
  description = "Helm repo ${google_storage_bucket.helm_repo.url} writer group"
}

resource "gsuite_group" "reader" {
  email       = "grp-helm-reader-${module.project.project_id}@${var.organization_domain_name}"
  name        = "grp-helm-reader-${module.project.project_id}@${var.organization_domain_name}"
  description = "Registry ${google_storage_bucket.helm_repo.url} reader group"
}

resource "google_storage_bucket_iam_member" "reader_group_object_viewer" {
  bucket = google_storage_bucket.helm_repo.name
  role   = "roles/storage.objectViewer"
  member = "group:${gsuite_group.reader.email}"
}

resource "google_storage_bucket_iam_member" "writer_group_object_admin" {
  bucket = google_storage_bucket.helm_repo.name
  role   = "roles/storage.objectAdmin"
  member = "group:${gsuite_group.writer.email}"
}
