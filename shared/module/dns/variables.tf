variable "project_name" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "root_dns_name" {
  type = string
}

variable "organization_domain_name" {
  type = string
}

variable "subdomain_records" {
  type = list(object({ subdomain = string, rrdatas = list(string) }))
}