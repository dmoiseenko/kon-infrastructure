module "builder" {
  source = "./module/builder"

  project_name             = var.build_project_name
  folder_id                = var.folder_id
  billing_account_id       = var.billing_account_id
  organization_domain_name = var.organization_domain_name
}

module "dns" {
  source = "./module/dns"

  project_name             = var.dns_project_name
  folder_id                = var.folder_id
  billing_account_id       = var.billing_account_id
  root_dns_name            = var.root_dns_name
  organization_domain_name = var.organization_domain_name
  subdomain_records = [
    {
      subdomain = "dev"
      rrdatas = [
        "ns-cloud-c1.googledomains.com.",
        "ns-cloud-c2.googledomains.com.",
        "ns-cloud-c3.googledomains.com.",
        "ns-cloud-c4.googledomains.com.",
      ]
    }
  ]
}

module "registry" {
  source = "./module/registry"

  project_name             = var.registry_project_name
  folder_id                = var.folder_id
  billing_account_id       = var.billing_account_id
  organization_domain_name = var.organization_domain_name
  registry_location        = "us-east1"
  registry_name            = "kon"
}

module "helm_repo" {
  source = "./module/helm_repo"

  project_name             = var.helm_repo_project_name
  folder_id                = var.folder_id
  billing_account_id       = var.billing_account_id
  organization_domain_name = var.organization_domain_name
}
