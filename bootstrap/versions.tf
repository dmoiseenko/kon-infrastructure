terraform {
  required_version = "1.3.0"
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
  }
}
