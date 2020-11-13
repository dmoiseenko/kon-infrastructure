output "project_id" {
  value = google_project.main.project_id
}

output "project_number" {
  value = google_project.main.number
}

output "service_account_email" {
  value = google_service_account.service_account.email
}
