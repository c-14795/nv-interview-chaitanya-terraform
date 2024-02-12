output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "node_pools" {
  value = google_container_node_pool.node_pools
}
output "creds" {
  value = null_resource.fetch_credentials
}

output "gke_details" {
  value = {
    host    = "https://${google_container_cluster.primary.endpoint}"
    ca_cert = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
    token   = data.google_client_config.current.access_token
  }
}