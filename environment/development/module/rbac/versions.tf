terraform {
  required_providers {
    gsuite = {
      version = "0.1.56"
      source  = "DeviaVir/gsuite"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.9.1"
    }
  }
}
