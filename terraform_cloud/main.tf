resource "tfe_organization" "dmoiseenko" {
  name  = "dmoiseenko"
  email = "dmoiseenko@mykolab.com"
}

resource "tfe_workspace" "org" {
  name                  = "org"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
}

resource "tfe_workspace" "terraform_cloud" {
  name                  = "terraform_cloud"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
}

resource "tfe_workspace" "group-kon-d" {
  name                  = "group_kon_d"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
}

resource "tfe_workspace" "prj_kon_d" {
  name                  = "prj_kon_d"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
}

resource "tfe_variable" "prj_kon_d_name" {
  key          = "prj_kon_d_name"
  value        = "prj-kon-d"
  category     = "terraform"
  workspace_id = tfe_workspace.group-kon-d.id
}

resource "tfe_variable" "prj_kon_d_prj_kon_d_name" {
  key          = "prj_kon_d_name"
  value        = "prj-kon-d"
  category     = "terraform"
  workspace_id = tfe_workspace.prj_kon_d.id
}

resource "tfe_workspace" "bootstrap" {
  name                  = "bootstrap"
  organization          = tfe_organization.dmoiseenko.id
  file_triggers_enabled = false
  queue_all_runs        = false
  operations            = false
}
