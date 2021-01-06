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

resource "google_dns_record_set" "dev_main_zone_ns" {
  count = length(var.subdomain_records)

  name         = "${var.subdomain_records[count.index].subdomain}.${var.root_dns_name}."
  type         = "NS"
  ttl          = 300
  managed_zone = google_dns_managed_zone.root.name
  rrdatas      = var.subdomain_records[count.index].rrdatas
  project      = module.project.project_id
}
