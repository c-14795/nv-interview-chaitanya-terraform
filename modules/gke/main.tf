resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = 1
  workload_identity_config {
    workload_pool = "${var.project}.svc.id.goog"
  }
  # Define other necessary configurations for the primary node pool
  # vpc connection is assumed default to this assignment scope.
}

data "google_client_config" "current" {}


provider "kubernetes" {
  host                   = "https://${google_container_cluster.primary.endpoint}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
  token                  = data.google_client_config.current.access_token
}


resource "null_resource" "fetch_credentials" {

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --region=${var.region}"
  }
  depends_on = [google_container_cluster.primary]
}

resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces
  metadata {
    name = each.value.name
  }

  depends_on = [google_container_cluster.primary, null_resource.fetch_credentials]

}

