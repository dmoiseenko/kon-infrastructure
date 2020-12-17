output "service_account_email_dns_admin" {
  value = module.dns_project.service_account_email
}

output "service_account_name_dns_admin" {
  value = module.dns_project.service_account_name
}

output "project_id" {
  value = module.dns_project.project_id
}
