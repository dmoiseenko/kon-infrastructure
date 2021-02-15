output "tf-org_project_id" {
  value = google_project.tf-org.project_id
}

output "tf-org-sa_service_account_email" {
  value = google_service_account.service_account.email
}