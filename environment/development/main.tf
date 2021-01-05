data "google_client_config" "provider" {}

module "development" {
  source = "./module/environment"

  organization_domain_name = var.organization_domain_name

  host_project_name  = "prj-d-kon"
  app_project_name   = "prj-d-kon-app"
  dns_project_name   = "prj-d-kon-dns"
  billing_account_id = var.billing_account_id
  folder_id          = var.folder_id

  vpc_network_name = "vpc-d-kon"
  vpc_subnets = [
    {
      subnet_name           = "kon"
      subnet_ip             = "11.0.4.0/22"
      subnet_region         = "us-east1"
      subnet_private_access = "true"
    },
  ]
  vpc_secondary_ranges = {
    kon = [
      {
        range_name    = "kon-services"
        ip_cidr_range = "11.0.32.0/20"
      },
      {

        range_name    = "kon-pods"
        ip_cidr_range = "11.4.0.0/14"
      },
    ]
  }

  gke_name                = "gke-d-kon"
  gke_location            = "us-east1-b"
  gke_is_preemptible_node = true
  gke_machine_type        = "e2-standard-2"
  gke_min_node_count      = 3
  gke_max_node_count      = 3
  gke_release_channel     = "REGULAR"

  domain_name = "dmoiseenko.me"
  subdomain   = "dev"

  terraform_service_account_email = "sa-tf-org@tf-org-08ad.iam.gserviceaccount.com"
}
