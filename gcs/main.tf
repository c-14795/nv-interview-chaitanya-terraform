resource "google_storage_bucket" "gcs_bucket" {
  name          = var.gcs_bucket_name
  location      = var.region
  project       = var.project_id
  force_destroy = true
  ## keeping it simple...
}

