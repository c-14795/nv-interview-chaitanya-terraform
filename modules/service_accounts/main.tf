
resource "google_service_account" "service_accounts" {
  project = var.project
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
#  create_ignore_already_exists = true
}