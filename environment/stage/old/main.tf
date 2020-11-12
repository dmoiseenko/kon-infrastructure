locals {
  prj_kon_d_name     = "prj-kon-d"
  network_name       = "vpc-kon-d"
  prj_kon_d_app_name = "prj-kon-d-app"
  gke_kon_d_app_name = "gke-kon-d"
  gke_location       = "us-east1-b"
  vpc_subnets = [
    {
      subnet_name           = "tier-1"
      subnet_ip             = "11.0.4.0/22"
      subnet_region         = "us-east1"
      subnet_private_access = "true"
    }
  ]
  vpc_secondary_ranges = {
    tier-1 = [
      {
        range_name    = "tier-1-services"
        ip_cidr_range = "11.0.32.0/20"
      },
      {

        range_name    = "tier-1-pods"
        ip_cidr_range = "11.4.0.0/14"
      },
    ]
  }
  proj_kon_d_activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
  prj_kon_d_default_service_account_roles = []
  prj_kon_d_app_activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
  ]
  prj_kon_d_app_default_service_account_roles = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
  ]
}

# resource "gsuite_group" "prj_kon_d_admin_group" {
#   email       = "group-${local.prj_kon_d_name}@${var.domain}"
#   name        = "group-${local.prj_kon_d_name}@${var.domain}"
#   description = "Admin group for project ${local.prj_kon_d_name}"
# }

# module "prj_kon_d" {
#   source = "../module/project"

#   project_name                  = local.prj_kon_d_name
#   billing_account               = var.billing_account
#   folder_id                     = google_folder.kon_dev.id
#   admin_group_email             = gsuite_group.prj_kon_d_admin_group.email
#   activate_apis                 = local.proj_kon_d_activate_apis
#   default_service_account_roles = local.prj_kon_d_default_service_account_roles
# }

# resource "gsuite_group" "prj_kon_d_app_admin_group" {
#   email       = "group-${local.prj_kon_d_app_name}@${var.domain}"
#   name        = "group-${local.prj_kon_d_app_name}@${var.domain}"
#   description = "Admin groug for project ${local.prj_kon_d_app_name}"
# }

# module "prj_kon_d_app" {
#   source = "../module/project"

#   project_name                  = local.prj_kon_d_app_name
#   billing_account               = var.billing_account
#   folder_id                     = google_folder.kon_dev.id
#   admin_group_email             = gsuite_group.prj_kon_d_app_admin_group.email
#   activate_apis                 = local.prj_kon_d_app_activate_apis
#   default_service_account_roles = local.prj_kon_d_app_default_service_account_roles
# }

# module "shared_vpc_host" {
#   source = "../module/shared_vpc_host"

#   project_id = module.prj_kon_d.project_id

#   depends_on = [
#     module.prj_kon_d
#   ]
# }

# module "vpc_kon_d" {
#   source  = "terraform-google-modules/network/google"
#   version = "2.5.0"

#   project_id   = module.prj_kon_d.project_id
#   network_name = local.network_name

#   subnets = local.vpc_subnets

#   secondary_ranges = local.vpc_secondary_ranges

#   depends_on = [
#     module.prj_kon_d,
#   ]
# }

# module "shared_vpc_service" {
#   source = "../module/shared_vpc_service"

#   project_id                    = module.prj_kon_d_app.project_id
#   project_number                = module.prj_kon_d_app.project_number
#   vpc_host_project_id           = module.prj_kon_d.project_id
#   shared_vpc_subnet_names       = [module.vpc_kon_d.subnets_names[0]]
#   shared_vpc_subnet_regions     = [module.vpc_kon_d.subnets_regions[0]]
#   admin_group_email             = gsuite_group.prj_kon_d_app_admin_group.email
#   default_service_account_email = module.prj_kon_d_app.default_service_account_email

#   depends_on = [
#     module.vpc_kon_d,
#     module.shared_vpc_host,
#   ]
# }

# module "gke" {
#   source = "../module/gke"

#   cluster_name                  = local.gke_kon_d_app_name
#   project_id                    = module.prj_kon_d_app.project_id
#   network_self_link             = module.vpc_kon_d.network_self_link
#   subnetwork_self_link          = module.vpc_kon_d.subnets_self_links[0]
#   pods_ip_range_name            = module.vpc_kon_d.subnets_secondary_ranges[0][1].range_name
#   services_ip_range_name        = module.vpc_kon_d.subnets_secondary_ranges[0][0].range_name
#   default_service_account_email = module.prj_kon_d_app.default_service_account_email
#   location                      = local.gke_location

#   depends_on = [
#     module.shared_vpc_service,
#   ]
# }
