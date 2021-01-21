locals {
  bucket_name = "${module.project.project_id}-helm"
}

module "project" {
  source = "git@github.com:dmoiseenko/kon-infrastructure.git//environment/development/module/gcp/project?ref=v0.0.9"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  service_account_roles    = []
  development_group_roles  = []
  activate_apis = [
    "storage-api.googleapis.com",
    "run.googleapis.com",
  ]
}

resource "google_storage_bucket" "helm_repo" {
  name                        = local.bucket_name
  project                     = module.project.project_id
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "sa_object_admin_role" {
  bucket = google_storage_bucket.helm_repo.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${module.project.service_account_email}"
}

resource "google_cloud_run_service" "chart_museum" {
  name     = "chart-museum"
  location = "us-east1"
  project  = module.project.project_id

  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/prj-sh-kon-registry-4846/kon/chartmuseum"
        env {
          name  = "STORAGE"
          value = "google"
        }
        env {
          name  = "STORAGE_GOOGLE_BUCKET"
          value = local.bucket_name
        }
        ports {
          container_port = 8080
        }
      }

      service_account_name = module.project.service_account_email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    module.project
  ]
}

# https://stackoverflow.com/questions/58947695/google-cloud-api-domainmapping-using-firebase-cloud-functions
resource "google_cloud_run_domain_mapping" "helm" {
  location = google_cloud_run_service.chart_museum.location
  name     = "helm.dmoiseenko.me"
  project  = module.project.project_id

  metadata {
    namespace = module.project.project_id
  }

  spec {
    route_name = google_cloud_run_service.chart_museum.name
  }
}

# TODO Add helm repo basic authentication
resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloud_run_service.chart_museum.location
  project  = google_cloud_run_service.chart_museum.project
  service  = google_cloud_run_service.chart_museum.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
