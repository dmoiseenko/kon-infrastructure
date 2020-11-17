output "group_gke_security" {
  value = gsuite_group.group_gke_security.email
}

output "endpoint_gke" {
  value = google_container_cluster.primary.endpoint
}

output "certificate_ca_gke" {
  value = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate,
  )
}
