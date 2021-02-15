output "project_id" {
  value = google_project.main.project_id
}

output "project_number" {
  value = google_project.main.number
}

output "service_account_email" {
  value = google_service_account.main.email
}

output "service_account_name" {
  value = google_service_account.main.name
}

output "group_admin_email" {
  value = gsuite_group.admin.email
}

output "group_dev_email" {
  value = gsuite_group.development.email
}
