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
    tfe = {
      source = "hashicorp/tfe"
      version = "0.22.0"
    }
  }
}

provider "gsuite" {
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.user",
  ]
}

provider "google" {
}

provider "google-beta" {
}

provider "random" {
}

provider "tfe" {
}