locals {

}

module "development" {
  source = "./module/environment"

  host_project_name  = "aasdasdasd"
  app_project_name   = "basddffff"
  billing_account_id = var.billing_account_id
  folder_id          = "937516052901"

  network_name = "vpc_kon"

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
}
