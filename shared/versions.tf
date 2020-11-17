terraform {
  required_version = "~> 0.13.4"
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

provider "google" {
}

provider "google-beta" {
}

provider "random" {
}
