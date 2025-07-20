resource "google_project_service" "backupdr" {
  project = var.project_id
  service = "backupdr.googleapis.com"
}