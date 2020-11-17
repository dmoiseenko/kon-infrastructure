locals {
  workspaces_with_billing_account_id = [
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

# denis_dev

resource "tfe_variable" "domain_name" {
  key          = "domain_name"
  value        = var.domain
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}

resource "tfe_variable" "development_folder_id" {
  key          = "folder_id"
  value        = google_folder.development.id
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}

# shared

resource "tfe_variable" "folder_shared_id" {
  key          = "folder_shared_id"
  value        = google_folder.shared.id
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "project_build_name" {
  key          = "project_build_name"
  value        = local.project_build_name
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}

resource "tfe_variable" "group_admin_project_build_shared" {
  key          = "group_admin_project_build_shared_email"
  value        = gsuite_group.group_admin_project_build_shared.email
  category     = "terraform"
  workspace_id = tfe_workspace.shared.id
}