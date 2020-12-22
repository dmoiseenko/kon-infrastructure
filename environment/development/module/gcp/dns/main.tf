module "dns_project" {
  source = "../project"

  project_name       = var.project_name
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id
  domain_name        = var.domain_name
  activate_apis = [
    "dns.googleapis.com",
    "iamcredentials.googleapis.com",
  ]
}

resource "google_project_iam_member" "host_project_admin_group_role" {
  member  = "serviceAccount:${module.dns_project.service_account_email}"
  project = module.dns_project.project_id
  role    = "roles/dns.admin"
}

resource "google_dns_managed_zone" "main_zone" {
  name     = replace(var.dns_name, ".", "-")
  dns_name = "${var.dns_name}."
  project  = module.dns_project.project_id

  depends_on = [module.dns_project]
}

resource "google_dns_managed_zone" "dev_main_zone" {
  name        = "dev-${replace(var.dns_name, ".", "-")}"
  dns_name    = "dev.${var.dns_name}."
  project     = module.dns_project.project_id
  description = "Automatically managed zone by ExternalDNS"

  depends_on = [module.dns_project]
}

resource "google_dns_record_set" "dev_main_zone_ns" {
  name         = "dev.${var.dns_name}."
  type         = "NS"
  ttl          = 300
  managed_zone = google_dns_managed_zone.main_zone.name
  rrdatas      = google_dns_managed_zone.dev_main_zone.name_servers
  project      = module.dns_project.project_id
}
