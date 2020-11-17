locals {
  organization_name = "dmoiseenko"
}

resource "tfe_organization" "dmoiseenko" {
  name  = local.organization_name
  email = "dmoiseenko@mykolab.com"
}

resource "tfe_workspace" "organization" {
  name                  = "organization"
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
  file_triggers_enabled = false
  queue_all_runs        = false

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}

resource "tfe_workspace" "shared" {
  name                  = "shared"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false

  lifecycle {
    ignore_changes = [vcs_repo]
  }
}
