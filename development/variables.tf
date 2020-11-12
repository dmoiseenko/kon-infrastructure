# variable "tf_org_project_id" {
#   type        = string
#   description = "The Terraform org-wide GCP project ID"
# }

# variable "org_id" {
#   type = string
#   description = "Google Cloud organization ID"
# }

# variable "tf_org_sa_email" {
#   type = string
#   description = "The Terrafrom org-wide service account"
# }

variable "billing_account_id" {
  type = string
  description = "The ID of the billing account to associate this project with"
}

# variable "domain" {
#   type = string
#   description = "The organization domain name"
# }
