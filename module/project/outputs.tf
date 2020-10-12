output "project_id" {
  value = google_project.main.project_id
}

output "project_number" {
  value = google_project.main.number
}

output "default_service_account_email" {
  value = google_service_account.default_service_account.email
}
