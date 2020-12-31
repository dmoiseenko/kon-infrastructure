# data "google_client_config" "provider" {}

# module "development" {
#   source = "./module/environment"

#   domain_name = var.domain_name

#   host_project_name  = "prj-kon-d"
#   app_project_name   = "prj-kon-app-d"
#   dns_project_name   = "prj-kon-dns-d"
#   billing_account_id = var.billing_account_id
#   folder_id          = var.folder_id

#   vpc_network_name = "vpc-kon-d"
#   vpc_subnets = [
#     {
#       subnet_name           = "kon"
#       subnet_ip             = "11.0.4.0/22"
#       subnet_region         = "us-east1"
#       subnet_private_access = "true"
#     },
#   ]
#   vpc_secondary_ranges = {
#     kon = [
#       {
#         range_name    = "kon-services"
#         ip_cidr_range = "11.0.32.0/20"
#       },
#       {

#         range_name    = "kon-pods"
#         ip_cidr_range = "11.4.0.0/14"
#       },
#     ]
#   }

#   gke_name                = "gke-kon-d"
#   gke_location            = "us-east1-b"
#   gke_is_preemptible_node = true
#   gke_machine_type        = "e2-standard-2"
#   gke_min_node_count      = 3
#   gke_max_node_count      = 3

#   dns_name = "dmoiseenko.me"
#   terraform_service_account_email = "sa-tf-org@tf-org-08ad.iam.gserviceaccount.com"
# }
