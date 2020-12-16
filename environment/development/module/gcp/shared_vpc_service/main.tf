resource "google_compute_shared_vpc_service_project" "shared_vpc_service" {
  host_project    = var.vpc_host_project_id
  service_project = var.project_id
}

resource "google_compute_subnetwork_iam_member" "service_account_role_to_vpc_subnets" {
  count = length(var.shared_vpc_subnet_names)

  project    = var.vpc_host_project_id
  region     = var.shared_vpc_subnet_regions[count.index]
  subnetwork = var.shared_vpc_subnet_names[count.index]
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.service_account_email}"

  depends_on = [
    google_compute_shared_vpc_service_project.shared_vpc_service
  ]
}

resource "google_project_iam_member" "gke_host_agent" {
  project = var.vpc_host_project_id
  role    = "roles/container.hostServiceAgentUser"
  member  = "serviceAccount:service-${var.project_number}@container-engine-robot.iam.gserviceaccount.com"

  depends_on = [
    google_compute_shared_vpc_service_project.shared_vpc_service
  ]
}

resource "google_compute_subnetwork_iam_member" "gke_service_account_role_to_vpc_subnets" {
  count = length(var.shared_vpc_subnet_names)

  project    = var.vpc_host_project_id
  region     = var.shared_vpc_subnet_regions[count.index]
  subnetwork = var.shared_vpc_subnet_names[count.index]
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${var.project_number}@container-engine-robot.iam.gserviceaccount.com"

  depends_on = [
    google_compute_shared_vpc_service_project.shared_vpc_service
  ]
}

resource "google_compute_subnetwork_iam_member" "api_service_account_role_to_vpc_subnets" {
  count = length(var.shared_vpc_subnet_names)

  project    = var.vpc_host_project_id
  region     = var.shared_vpc_subnet_regions[count.index]
  subnetwork = var.shared_vpc_subnet_names[count.index]
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com"

  depends_on = [
    google_compute_shared_vpc_service_project.shared_vpc_service
  ]
}
