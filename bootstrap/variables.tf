variable "project_name" {
  type        = string
  description = "GCP project name"
}

variable "org_id" {
  type = string
  description = "Google Cloud organization ID"
}

variable "billing_account" {
  type = string
  description = "The ID of the billing account to associate this project with"
}

variable "terraform_service_account_name" {
  type = string
  description = "The org-wide Terrafrom service account name"
}

variable "group_org_admin" {
  type = string
  description = "The group org admin email"
}

variable "group_billing_admin" {
  type = string
  description = "The group billing admin email"
}

variable "group_network_admin" {
  type = string
  description = "The group network admin email"
}
