output "cluster_name" {
  value = module.gke_cluster.cluster_name
}
output "gcp_services_project"{
  value =  module.gcp_services.project_id
}
output "node_pools" {
  value = module.gke_cluster.node_pools
}
output "hive_metastore" {
  value = module.hive_metastore.dataproc_hive_metastore_cluster
}
output "gke_creds" {
  value = module.gke_cluster.creds
}
output "gke_details" {
  value = module.gke_cluster.gke_details
  sensitive = true
}
output "gcp_service_account" {
  value = module.airflow.gcp_service_account
}