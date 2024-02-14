resource "google_service_account" "service_accounts" {
  project      = var.project
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
  #  create_ignore_already_exists = true
}

locals {
  sa_email = "serviceAccount:${google_service_account.service_accounts.email}"
}
resource "google_project_iam_member" "role_bindings" {
  for_each = toset(var.roles)
  role     = each.value
  project  = var.project
  member   = local.sa_email
}