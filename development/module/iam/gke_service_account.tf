module "gke_service_account_iam" {
  source  = "terraform-google-modules/iam/google//modules/member_iam"
  version = "6.3.1"

  service_account_address = var.gke_service_account_email
  prefix                  = "serviceAccount"
  project_id              = var.gke_project_id
  project_roles = [
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/logging.logWriter",
  ]
}
