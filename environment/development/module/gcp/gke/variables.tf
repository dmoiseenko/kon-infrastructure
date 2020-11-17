variable "project_id" {
  type = string
}

variable "domain_name" {
  type = string
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

variable "description" {
  type    = string
  default = ""
}

variable "is_preemptible_node" {
  type = bool
}

variable "machine_type" {
  type = string
}

variable "min_node_count" {
  type = number
}

variable "max_node_count" {
  type = number
}
