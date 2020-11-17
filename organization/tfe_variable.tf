locals {
  # workspaces_with_billing_account_id = [
  #   tfe_workspace.denis_dev.id,
  # ]
}

resource "tfe_variable" "billing_account_id" {
  # count = length(local.workspaces_with_billing_account_id)

  key          = "billing_account_id"
  value        = var.billing_account
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}

resource "tfe_variable" "host_project_name_development" {
  key          = "host_project_name"
  value        = local.host_project_name_development
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}

resource "tfe_variable" "app_project_name_development" {
  key          = "app_project_name"
  value        = local.app_project_name_development
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}

resource "tfe_variable" "development_folder_id" {
  key          = "folder_id"
  value        = google_folder.development.id
  category     = "terraform"
  workspace_id = tfe_workspace.denis_dev.id
}
