resource "google_organization_policy" "automatic_iam_grants_for_default_service_accounts" {
  org_id     = var.org_id
  constraint = "iam.automaticIamGrantsForDefaultServiceAccounts"

  boolean_policy {
    enforced = true
  }
}

resource "google_organization_policy" "skip_default_network_creation" {
  org_id     = var.org_id
  constraint = "compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}
