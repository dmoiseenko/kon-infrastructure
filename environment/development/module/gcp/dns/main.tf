module "dns_project" {
  source = "../project"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  development_group_roles  = []
  admin_group_roles        = []
  service_account_roles = [
    "roles/dns.admin",
  ]
  activate_apis = [
    "dns.googleapis.com",
  ]
}

resource "google_dns_managed_zone" "subdomain_zone" {
  name     = "${var.subdomain}-${replace(var.domain_name, ".", "-")}"
  dns_name = "${var.subdomain}.${var.domain_name}."
  project  = module.dns_project.project_id
  dnssec_config {
    state = "on"
  }
  description = "Automatically managed zone by ExternalDNS"

  depends_on = [module.dns_project]
}
