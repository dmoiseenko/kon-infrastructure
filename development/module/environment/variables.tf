variable "host_project_name" {
  type = string
}

variable "app_project_name" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "network_name" {
  type = string
}

variable "vpc_subnets" {
  type = list(map(string))
}

variable "vpc_secondary_ranges" {
  type = map(list(object({ range_name = string, ip_cidr_range = string })))
}

variable "asd" {
  type = string
  default = ""
}
variable "gke_location" {
  type = string
}

variable "gke_name" {
  type = string
}
