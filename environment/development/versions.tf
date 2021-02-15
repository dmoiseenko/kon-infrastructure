terraform {
  required_version = "0.14.3"
  required_providers {
    google = {
      version = "3.47.0"
      source  = "hashicorp/google"
    }
    google-beta = {
      version = "3.47.0"
      source  = "hashicorp/google-beta"
    }
    random = {
      version = "2.3.0"
      source  = "hashicorp/random"
    }
    gsuite = {
      version = "0.1.56"
      source  = "DeviaVir/gsuite"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.9.4"
    }
  }
}

provider "google" {
}

provider "google-beta" {
}

provider "random" {
}

provider "gsuite" {
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.user",
  ]
}

# provider "kubectl" {
#   load_config_file = false

#   host                   = "https://${module.development.endpoint_gke}"
#   token                  = data.google_client_config.provider.access_token
#   cluster_ca_certificate = module.development.certificate_ca_gke
# }