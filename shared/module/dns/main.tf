module "project" {
  source = "git@github.com:dmoiseenko/kon-infrastructure.git//environment/development/module/gcp/project?ref=v0.0.9"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  service_account_roles    = []
  development_group_roles  = []
  activate_apis = [
    "dns.googleapis.com",
  ]
}

resource "google_dns_managed_zone" "root" {
  name     = replace(var.root_dns_name, ".", "-")
  dns_name = "${var.root_dns_name}."
  project  = module.project.project_id
  dnssec_config {
    state = "on"
  }

  depends_on = [
    module.project,
  ]
}
