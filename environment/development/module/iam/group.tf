resource "google_project_iam_member" "host_project_admin_group_role" {
  member  = "group:${var.group_email_host_project_admin}"
  project = var.host_project_id
  role    = "roles/editor"
}

resource "google_project_iam_member" "app_project_admin_group_role_project_editor" {
  member  = "group:${var.group_email_app_project_admin}"
  project = var.app_project_id
  role    = "roles/editor"
}

resource "google_project_iam_member" "app_project_admin_group_role_container_admin" {
  member  = "group:${var.group_email_app_project_admin}"
  project = var.app_project_id
  role    = "roles/container.admin"
}
