terraform {
  backend "remote" {
    organization = "dmoiseenko"

    workspaces {
      name = "bootstrap"
    }
  }
}
