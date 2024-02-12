resource "google_project_service" "enable_disable_services" {
  project = var.project
  count = length(var.services_to_be_enabled)
  service = var.services_to_be_enabled[count.index]
  disable_on_destroy = true
  disable_dependent_services = true
}
