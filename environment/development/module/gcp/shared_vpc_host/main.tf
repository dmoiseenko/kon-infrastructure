resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
    project = var.host_project_id
}
