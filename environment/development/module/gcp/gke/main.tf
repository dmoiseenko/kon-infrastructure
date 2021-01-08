resource "gsuite_group" "group_gke_security" {
  email       = "gke-security-groups-${var.project_id}@${var.domain_name}"
  name        = "gke-security-groups-${var.project_id}@${var.domain_name}"
  description = "GKE security group for project ${var.project_id}"
}

module "gke_app_service_account_email" {
  source  = "terraform-google-modules/iam/google//modules/member_iam"
  version = "6.3.1"

  service_account_address = var.service_account_email
  prefix                  = "serviceAccount"
  project_id              = var.project_id
  project_roles = [
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/logging.logWriter",
  ]
}

resource "google_container_cluster" "primary" {
  provider = google-beta

  name        = var.cluster_name
  description = var.description
  location    = var.location
  project     = var.project_id

  release_channel {
    channel = var.release_channel
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

  initial_node_count       = 1
  remove_default_node_pool = true
  node_config {
    service_account = var.service_account_email
  }

  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  pod_security_policy_config {
    enabled = false
  }

  authenticator_groups_config {
    security_group = gsuite_group.group_gke_security.email
  }

  depends_on = [
    gsuite_group.group_gke_security
  ]
  lifecycle {
    ignore_changes        = [node_config]
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "main-node-pool"
  cluster    = google_container_cluster.primary.name
  node_count = var.min_node_count
  project    = var.project_id
  location   = var.location

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = var.is_preemptible_node
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = true
    }

    service_account = var.service_account_email
  }
}

resource "gsuite_group" "gke_group_admin" {
  email       = "group-gke-admin-${var.cluster_name}-${var.project_id}@${var.domain_name}"
  name        = "group-gke-admin-${var.cluster_name}-${var.project_id}@${var.domain_name}"
  description = "GKE admin group for cluster ${var.cluster_name} in project ${var.project_id}"
}

resource "google_project_iam_member" "gke_admin_group" {
  member  = "group:${gsuite_group.gke_group_admin.email}"
  project = var.project_id
  role    = "roles/container.admin"
}

resource "gsuite_group_member" "group_gke_security" {
  group = gsuite_group.group_gke_security.email
  email = gsuite_group.gke_group_admin.email
  role  = "MEMBER"
}

resource "google_service_account_iam_member" "external_dns" {
  service_account_id = var.dns_admin_service_account_name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[external-dns/external-dns]"

  depends_on = [
    google_container_cluster.primary
  ]
}

resource "google_service_account_iam_member" "cert_manager" {
  service_account_id = var.dns_admin_service_account_name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[cert-manager/cert-manager]"

  depends_on = [
    google_container_cluster.primary
  ]
}

resource "google_service_account_iam_member" "vault" {
  service_account_id = var.vault_service_account_name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[vault/vault]"

  depends_on = [
    google_container_cluster.primary
  ]
}
