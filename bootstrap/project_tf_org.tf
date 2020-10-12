resource "google_project" "tf-org" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_id.random_project_id_suffix.hex}"
  org_id          = var.org_id
  billing_account = var.billing_account
}
