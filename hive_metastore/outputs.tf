output "dataproc_hive_metastore_cluster" {
  value = google_dataproc_metastore_service.hive_metastore.endpoint_uri
}