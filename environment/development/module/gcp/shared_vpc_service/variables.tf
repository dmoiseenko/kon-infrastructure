variable "project_id" {
  type        = string
  description = "Project Id"
}

variable "project_number" {
  type = string
}

variable "vpc_host_project_id" {
  type        = string
  description = "The Shared VPC host project Id"
}

variable "shared_vpc_subnet_regions" {
  type    = list(string)
  default = []
}

variable "shared_vpc_subnet_names" {
  type    = list(string)
  default = []
}

# variable "admin_group_email" {
#   type    = string
# }

variable "service_account_email" {
  type    = string
}
