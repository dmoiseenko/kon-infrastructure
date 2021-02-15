resource "tfe_workspace" "shared" {
  name                  = "shared"
  terraform_version     = "0.14.3"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false

  lifecycle {
    ignore_changes = [vcs_repo, ssh_key_id]
  }
}

resource "tfe_variable" "shared_folder_id" {
  key          = "folder_id"
  value        = google_folder.shared.id
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_build_project_name" {
  key          = "build_project_name"
  value        = local.shared_build_project_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_dns_project_name" {
  key          = "dns_project_name"
  value        = local.shared_dns_project_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_registry_project_name" {
  key          = "registry_project_name"
  value        = local.shared_registry_project_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_helm_repo_project_name" {
  key          = "helm_repo_project_name"
  value        = local.shared_helm_repo_project_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_root_dns_name" {
  key          = "root_dns_name"
  value        = local.root_dns_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_billing_account_id" {
  key          = "billing_account_id"
  value        = var.billing_account
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "shared_organization_domain_name" {
  key          = "organization_domain_name"
  value        = var.organization_domain_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}
