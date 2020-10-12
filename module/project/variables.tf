variable "project_name" {
  type        = string
  description = "Project name"
}

variable "folder_id" {
  type        = string
  description = "Folder Id"
}

variable "billing_account" {
  type        = string
  description = "The Id of the billing account to associate this project with"
}

variable "is_vpc_host" {
  type        = bool
  description = "Indicates that the project is Shared VPC host"
  default     = false
}

variable "is_vpc_service" {
  type        = bool
  description = "Indicates that the project is Shared VPC service"
  default     = false
}

variable "vpc_host_project_id" {
  type        = string
  description = "The Shared VPC host project Id"
  default     = ""
}

variable "shared_vpc_subnet_regions" {
  type    = list(string)
  default = []
}

variable "shared_vpc_subnet_names" {
  type    = list(string)
  default = []
}

variable "admin_group_email" {
  type = string
}

variable "activate_apis" {
  type = list(string)
}

variable "default_service_account_roles" {
  type = list(string)
}
