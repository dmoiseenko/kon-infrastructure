resource "google_project" "main" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_id.random_project_id_suffix.hex}"
  folder_id       = var.folder_id
  billing_account = var.billing_account_id
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "4.0.0"

  project_id = google_project.main.project_id
  activate_apis = [
    "dns.googleapis.com",
  ]

  depends_on = [
    google_project.main,
  ]
}

resource "google_project_default_service_accounts" "main" {
  project = google_project.main.project_id
  action  = "DELETE"

  depends_on = [
    module.project_services,
  ]
}

resource "google_dns_managed_zone" "root" {
  name     = replace(var.root_dns_name, ".", "-")
  dns_name = "${var.root_dns_name}."
  project  = google_project.main.project_id

  depends_on = [module.project_services]
}

# resource "google_project_iam_member" "host_project_admin_group_role" {
#   member  = "serviceAccount:${module.main.service_account_email}"
#   project = module.main.project_id
#   role    = "roles/dns.admin"
# }

# resource "google_dns_managed_zone" "dev_main_zone" {
#   name        = "dev-${replace(var.main_dns_name, ".", "-")}"
#   dns_name    = "dev.${var.main_dns_name}."
#   project     = module.main.project_id
#   description = "Automatically managed zone by ExternalDNS"

#   depends_on = [module.main]
# }

# resource "google_dns_record_set" "dev_main_zone_ns" {
#   name         = "dev.${var.main_dns_name}."
#   type         = "NS"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.main.name
#   rrdatas      = google_dns_managed_zone.dev_main_zone.name_servers
#   project      = module.main.project_id
# }
