locals {
  workspaces_with_billing_account_id = [
    tfe_workspace.denis_dev.id,
  ]
  workspaces_with_organization_domain_name = [
    tfe_workspace.denis_dev.id,
  ]
}

resource "tfe_variable" "billing_account_id" {
  count = length(local.workspaces_with_billing_account_id)

  key          = "billing_account_id"
  value        = var.billing_account
  category     = "terraform"
  workspace_id = local.workspaces_with_billing_account_id[count.index]
}

resource "tfe_variable" "organization_domain_name" {
   count = length(local.workspaces_with_organization_domain_name)

  key          = "organization_domain_name"
  value        = var.organization_domain_name
  category     = "terraform"
  workspace_id = local.workspaces_with_organization_domain_name[count.index]
}

# denis_dev

resource "tfe_variable" "development_folder_id" {
  key          = "folder_id"
  value        = google_folder.development.id
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}
