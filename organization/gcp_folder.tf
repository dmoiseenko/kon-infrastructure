resource "google_folder" "sandbox" {
  display_name = "sandbox"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "kon" {
  display_name = "kon"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "development" {
  display_name = "development"
  parent       = google_folder.kon.id
}

resource "google_folder" "shared" {
  display_name = "shared"
  parent       = google_folder.kon.id
}
