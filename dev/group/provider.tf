terraform {
  required_version = "0.13.5"
  required_providers {
    gsuite = {
      version = "0.1.56"
      source  = "DeviaVir/gsuite"
    }
  }
}

provider "gsuite" {
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.user",
  ]
}
