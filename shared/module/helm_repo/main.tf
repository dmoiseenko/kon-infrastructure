module "project" {
  source = "git@github.com:dmoiseenko/kon-infrastructure.git//environment/development/module/gcp/project?ref=v0.0.8"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  service_account_roles    = []
  development_group_roles  = []
  activate_apis = [
    "storage-api.googleapis.com"
  ]
}

resource "google_storage_bucket" "helm_repo" {
  name    = "${module.project.project_id}-helm"
  project = module.project.project_id
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.helm_repo.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
