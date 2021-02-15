output "oauth_client_id" {
  value = google_iap_client.project_client.client_id
}

output "oauth_client_secret" {
  value = google_iap_client.project_client.secret
}
