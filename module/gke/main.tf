resource "google_container_cluster" "primary" {
  provider = google-beta

  name        = var.cluster_name
  description = ""
  location    = var.location
  project     = var.project_id

  release_channel {
    channel = "REGULAR"
  }

  network         = var.network_self_link
  subnetwork      = var.subnetwork_self_link
  networking_mode = "VPC_NATIVE"
  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_ip_range_name
    services_secondary_range_name = var.services_ip_range_name
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  initial_node_count = 1
  remove_default_node_pool = true
  node_config {
    service_account = var.default_service_account_email
  }

  # lifecycle {
  #   ignore_changes = [node_pool]
  # }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "main-node-pool"
  cluster    = google_container_cluster.primary.name
  node_count = 3
  project    = var.project_id
  location   = var.location

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 3
    max_node_count = 6
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    service_account = var.default_service_account_email
  }
}
