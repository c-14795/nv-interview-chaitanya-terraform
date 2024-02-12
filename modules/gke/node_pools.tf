resource "google_container_node_pool" "node_pools" {
  count      = length(var.node_pools)
  name       = var.node_pools[count.index].name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  initial_node_count = var.node_pools[count.index].initial_node_count
  node_config {
    machine_type = var.node_pools[count.index].machine_type
  }
  autoscaling {
    min_node_count = var.node_pools[count.index].min_count
    max_node_count = var.node_pools[count.index].max_count
  }

  # Add other necessary configurations for each node pool
}
