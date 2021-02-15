module "secret_project" {
  source = "../project"

  project_name             = var.project_name
  billing_account_id       = var.billing_account_id
  folder_id                = var.folder_id
  organization_domain_name = var.organization_domain_name
  development_group_roles  = []
  admin_group_roles        = []
  service_account_roles    = []
  activate_apis = [
    "cloudkms.googleapis.com",
  ]
}

resource "google_service_account" "vault_service_account" {
  project = module.secret_project.project_id

  account_id   = "sa-vault"
  display_name = "Hashicorp Vault Service Account"
}

resource "google_project_iam_custom_role" "vault-custom-role" {
  role_id = "vaultCustomRole"
  title   = "Hashicorp Vault Custom Role"
  project = module.secret_project.project_id
  permissions = [
    "cloudkms.cryptoKeyVersions.useToEncrypt",
    "cloudkms.cryptoKeyVersions.useToDecrypt",
    "cloudkms.cryptoKeys.get",
  ]
}

resource "google_kms_key_ring" "kon" {
  name     = "keyring-kon"
  location = "global"
  project  = module.secret_project.project_id

  depends_on = [
    module.secret_project
  ]
}

resource "google_kms_crypto_key" "crypto-key-vault" {
  name            = "crypto-key-vault"
  key_ring        = google_kms_key_ring.kon.id
  rotation_period = "100000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_member" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.crypto-key-vault.id
  role          = google_project_iam_custom_role.vault-custom-role.name
  member        = "serviceAccount:${google_service_account.vault_service_account.email}"
}

resource "google_storage_bucket" "vault_storage" {
  name                        = "vault-storage-${module.secret_project.project_id}"
  project                     = module.secret_project.project_id
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_member" "service_account_storage_admin_vault_storage" {
  bucket = google_storage_bucket.vault_storage.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.vault_service_account.email}"
}
