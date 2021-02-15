resource "google_project_service" "serviceusage" {
  project = google_project.tf-org.project_id
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  project = google_project.tf-org.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "admin" {
  project = google_project.tf-org.project_id
  service = "admin.googleapis.com"
}

resource "google_project_service" "cloudbilling" {
  project = google_project.tf-org.project_id
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "iam" {
  project = google_project.tf-org.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "container" {
  project = google_project.tf-org.project_id
  service = "container.googleapis.com"
}

resource "google_project_service" "cloudkms" {
  project = google_project.tf-org.project_id
  service = "cloudkms.googleapis.com"
}
