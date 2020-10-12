 terraform {
  backend "remote" {
    organization = "dmoiseenko"

    workspaces {
      name = "org"
    }
  }
}
