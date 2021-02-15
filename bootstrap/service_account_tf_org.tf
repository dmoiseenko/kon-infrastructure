resource "google_service_account" "service_account" {
  project      = google_project.tf-org.project_id
  account_id   = var.terraform_service_account_name
  display_name = "Org-wide Terraform service account"
}
