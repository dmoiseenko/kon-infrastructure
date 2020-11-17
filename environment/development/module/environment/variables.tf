variable "domain_name" {
  type = string
}

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

variable "vpc_network_name" {
  type = string
}

variable "vpc_subnets" {
  type = list(map(string))
}

variable "vpc_secondary_ranges" {
  type = map(list(object({ range_name = string, ip_cidr_range = string })))
}

variable "gke_location" {
  type = string
}

variable "gke_name" {
  type = string
}

variable "gke_is_preemptible_node" {
  type = bool
}

variable "gke_machine_type" {
  type = string
}

variable "gke_min_node_count" {
  type = number
}

variable "gke_max_node_count" {
  type = number
}

