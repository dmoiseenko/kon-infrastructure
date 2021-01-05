resource "gsuite_group" "group_iap_support" {
  email       = "support-${var.project_id}@${var.domain_name}"
  name        = "support-${var.project_id}@${var.domain_name}"
  description = "Support group for IAP in ${var.project_id}"
}

# https://github.com/hashicorp/terraform-provider-google/issues/6104
resource "gsuite_group_member" "support_owner" {
  group = gsuite_group.group_iap_support.email
  email = var.terraform_service_account_email
  role  = "OWNER"
}

resource "google_iap_brand" "kon" {
  support_email     = gsuite_group.group_iap_support.email
  application_title = "kon"
  project           = var.project_id

  depends_on = [
    gsuite_group_member.support_owner
  ]
}

resource "google_iap_client" "project_client" {
  display_name = "kon client"
  brand        = google_iap_brand.kon.name
}

resource "google_iap_web_iam_member" "member" {
  project = var.project_id
  role    = "roles/iap.httpsResourceAccessor"
  member  = "domain:${var.domain_name}"

  depends_on = [
    google_iap_brand.kon,
  ]
}
