resource "google_dataproc_metastore_service" "hive_metastore" {
  location        = var.region
  project         = var.project_id
  service_id      = var.meta_store_cluster_name
  tier            = "DEVELOPER"
  port            = 9080
  database_type   = "MYSQL"
  release_channel = "STABLE"

  hive_metastore_config {
    version           = "3.1.2"
    endpoint_protocol = "THRIFT"
    config_overrides  = {
      "hive.metastore.warehouse.dir" = "gs://${var.hive_metastore_bucket}/hive/warehouse"
    }
  }
}
