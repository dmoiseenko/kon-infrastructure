variable "service_project_id" {
  type = string
}

variable "service_project_number" {
  type = string
}

variable "vpc_host_project_id" {
  type = string
}

variable "shared_vpc_subnet_regions" {
  type = list(string)
}

variable "shared_vpc_subnet_names" {
  type = list(string)
}

variable "service_account_email" {
  type = string
}
