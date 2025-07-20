resource "google_project_iam_member" "backup_admin" {
  project = var.project_id
  role    = "roles/backupdr.admin"
  member  = "serviceAccount:service-${var.project_number}@gcp-sa-backupdr.iam.gserviceaccount.com"
}
