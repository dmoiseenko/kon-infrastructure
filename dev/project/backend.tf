terraform {
  backend "remote" {
    organization = "dmoiseenko"

    workspaces {
      name = "prj_kon_d"
    }
  }
}
