data "google_project" "project" {
  project_id = var.project_id
}

data "google_container_engine_versions" "current" {
  provider       = google-beta
  location       = var.region
  version_prefix = "1.25."
}
