resource "tfe_organization" "dmoiseenko" {
  name  = var.organization_name
  email = var.organization_admin_email
}

resource "tfe_workspace" "organization" {
  name                  = "organization"
  terraform_version     = "0.14.3"
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
  terraform_version     = "0.14.3"
  file_triggers_enabled = false
  queue_all_runs        = false
  operations            = false
}

resource "tfe_workspace" "denis_dev" {
  name                  = "denis_dev"
  terraform_version     = "0.14.3"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}

resource "tfe_workspace" "shared" {
  name                  = "shared"
  terraform_version     = "0.14.3"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}
