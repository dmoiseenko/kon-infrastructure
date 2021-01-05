resource "google_compute_firewall" "gke-load-balancer" {
  name    = "gke-load-balancer"
  network = var.network_name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_service_accounts = [var.target_service_account_email]
}
