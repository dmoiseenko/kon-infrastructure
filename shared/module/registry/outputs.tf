output "project_id" {
  value = module.project.project_id
}

# output "registry_url" {
#   value = google_artifact_registry_repository.kon.
# }

output "registry_writer_group" {
  value = gsuite_group.writer.email
}

output "registry_reader_group" {
  value = gsuite_group.reader.email
}
