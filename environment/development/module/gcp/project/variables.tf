variable "project_name" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "activate_apis" {
  type = list(string)
}

variable "service_account_roles" {
  type = list(string)
}

variable "development_group_roles" {
  type = list(string)
}

variable "admin_group_roles" {
  type = list(string)
}

variable "organization_domain_name" {
  type = string
}
