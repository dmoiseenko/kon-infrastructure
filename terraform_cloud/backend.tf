terraform {
  backend "remote" {
    organization = "dmoiseenko"

    workspaces {
      name = "terraform_cloud"
    }
  }
}