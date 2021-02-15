module "project" {
  source = "git@github.com:dmoiseenko/kon-infrastructure.git//environment/development/module/gcp/project?ref=v1.0.0"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  service_account_roles = [
    "roles/cloudbuild.builds.builder",
    "roles/storage.objectViewer",
  ]
  development_group_roles = []
  activate_apis = [
    "cloudbuild.googleapis.com",
  ]
  admin_group_roles        = []
}

resource "google_storage_bucket" "bucket_project_id" {
  name                        = module.project.project_id
  project                     = module.project.project_id
  uniform_bucket_level_access = true
  force_destroy = true
}
