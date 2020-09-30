terraform {
  backend "remote" {
    organization = "kon"

    workspaces {
      name = "terraform-iam"
    }
  }
}
