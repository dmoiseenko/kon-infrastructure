variable "project_id" {
  type        = string
  description = "Project Id"
}

variable "network_self_link" {
  type = string
}

variable "pods_ip_range_name" {
  type = string
}

variable "services_ip_range_name" {
  type = string
}

variable "subnetwork_self_link" {
  type = string
}

variable "default_service_account_email" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_name" {
  type = string
}
