locals {
  workspaces_with_billing_account_id = [
    tfe_workspace.denis_dev.id,
    tfe_workspace.shared.id
  ]
  workspaces_with_domain_name = [
    tfe_workspace.denis_dev.id,
    tfe_workspace.shared.id
  ]
}

resource "tfe_variable" "billing_account_id" {
  count = length(local.workspaces_with_billing_account_id)

  key          = "billing_account_id"
  value        = var.billing_account
  category     = "terraform"
  workspace_id = local.workspaces_with_billing_account_id[count.index]
}

resource "tfe_variable" "domain_name" {
   count = length(local.workspaces_with_domain_name)

  key          = "domain_name"
  value        = var.domain
  category     = "terraform"
  workspace_id = local.workspaces_with_domain_name[count.index]
}

# denis_dev

resource "tfe_variable" "development_folder_id" {
  key          = "folder_id"
  value        = google_folder.development.id
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}

# shared

resource "tfe_variable" "shared_folder_id" {
  key          = "folder_id"
  value        = google_folder.shared.id
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "build_project_name" {
  key          = "build_project_name"
  value        = local.build_project_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "dns_project_name" {
  key          = "dns_project_name"
  value        = local.dns_project_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "root_dns_name" {
  key          = "root_dns_name"
  value        = local.root_dns_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}
