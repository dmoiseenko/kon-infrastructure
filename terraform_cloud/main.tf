locals {
  organization_name = "dmoiseenko"
}

resource "tfe_organization" "dmoiseenko" {
  name  = local.organization_name
  email = "dmoiseenko@mykolab.com"
}

resource "tfe_workspace" "org" {
  name                  = "organization"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
}

resource "tfe_workspace" "terraform_cloud" {
  name                  = "terraform_cloud"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}

resource "tfe_workspace" "bootstrap" {
  name                  = "bootstrap"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
  operations            = false
}

resource "tfe_workspace" "denis_dev" {
  name                  = "denis_dev"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = true
  queue_all_runs        = false
  working_directory = "development/"

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}

locals {
  host_project_name_development = "prj-kon-d"
  app_project_name_development = "prj-kon-app-d"
  workspaces_with_billing_account_id = [
    tfe_workspace.denis_dev.id,
  ]
}

resource "tfe_variable" "billing_account_id" {
  count = length(local.workspaces_with_billing_account_id)

  key          = "billing_account_id"
  value        = var.billing_account_id
  category     = "terraform"
  workspace_id = local.workspaces_with_billing_account_id[count.index]
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

data "terraform_remote_state" "organization" {
  backend = "remote"

  config = {
    organization = local.organization_name
    workspaces = {
      name = tfe_workspace.org.name
    }
  }
}
