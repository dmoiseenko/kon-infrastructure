output "project_id" {
  value = module.secret_project.project_id
}

output "vault_service_account_email" {
  value = google_service_account.vault_service_account.email
}

output "vault_service_account_name" {
  value = google_service_account.vault_service_account.name
}
