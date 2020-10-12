resource "google_organization_iam_member" "tf_org_organizationViewer" {
  org_id = var.org_id
  role   = "roles/resourcemanager.organizationViewer"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_organization_iam_member" "tf_org_folderEditor" {
  org_id = var.org_id
  role   = "roles/resourcemanager.folderEditor"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_organization_iam_member" "tf_org_folderCreator" {
  org_id = var.org_id
  role   = "roles/resourcemanager.folderCreator"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_billing_account_iam_member" "tf_org_billing_user" {
  billing_account_id = var.billing_account
  role               = "roles/billing.user"
  member             = "serviceAccount:${google_service_account.service_account.email}"
}

# resource "google_organization_iam_member" "tf_org_network_admin" {
#   org_id = var.org_id
#   role   = "roles/compute.networkAdmin"
#   member = "serviceAccount:${google_service_account.service_account.email}"
# }

resource "google_organization_iam_member" "tf_org_xpn_admin" {
  org_id = var.org_id
  role   = "roles/compute.xpnAdmin"
  member = "serviceAccount:${google_service_account.service_account.email}"
}
