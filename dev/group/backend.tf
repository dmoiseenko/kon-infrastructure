terraform {
  backend "remote" {
    organization = "dmoiseenko"

    workspaces {
      name = "group_kon_d"
    }
  }
}
