module "dns_project" {
  source = "../project"

  project_name       = var.project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  domain_name        = var.domain_name
  activate_apis = [
    "dns.googleapis.com",
  ]
}

resource "google_dns_managed_zone" "main_zone" {
  name     = replace(var.dns_name, ".", "-")
  dns_name = "${var.dns_name}."
  project  = module.dns_project.project_id
}

resource "google_dns_managed_zone" "dev_main_zone" {
  name     = "dev-${replace(var.dns_name, ".", "-")}"
  dns_name = "dev.${var.dns_name}."
  project  = module.dns_project.project_id
}

resource "google_dns_record_set" "dev_main_zone_ns" {
  name = "dev.${var.dns_name}."
  type = "NS"
  ttl  = 300

  managed_zone = google_dns_managed_zone.main_zone.name

  rrdatas = google_dns_managed_zone.dev_main_zone.name_servers
}
