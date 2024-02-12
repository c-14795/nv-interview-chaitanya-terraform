# Define the GKE cluster module

provider "google" {
  project     = var.project
  credentials = var.creds
}

module "gcp_services" {
  source                 = "../../modules/gcp_services"
  services_to_be_enabled = var.services_to_be_enabled
  project                = var.project

}

module "gke_cluster" {
  source = "../../modules/gke"

  project      = module.gcp_services.project_id
  # Cluster configurations
  cluster_name = var.gke_cluster_name
  region       = var.region

  # Network configurations
  subnet   = var.subnet
  vpc_name = var.vpc_name

  # Node pools configurations
  node_pools = var.gke_node_pools

  # namespaces to be created inside the cluster
  namespaces = var.namespaces_in_gke

}


# gcs  bucket creation
module "gcs" {
  count           = length(var.gcs_bucket_names)
  source          = "../../modules/gcs"
  gcs_bucket_name = var.gcs_bucket_names[count.index]
  project_id      = module.gcp_services.project_id
  region          = var.region
}

# dataproc metastore service for hive metastore
module "hive_metastore" {
  source                  = "../../modules/hive_metastore"
  hive_metastore_bucket   = var.hive_metastore_bucket
  meta_store_cluster_name = var.meta_store_cluster_name
  project_id              = module.gcp_services.project_id
  region                  = var.region
  depends_on              = [module.gcs]
}


## airflow deployment module...
module "airflow" {
  source                = "../../modules/airflow"
  default_tag           = var.airflow_tag
  executor              = var.airflow_executor
  gke_cluster_name      = module.gke_cluster.cluster_name
  helm_version          = var.airflow_helm_chart_version
  namespace             = var.namespaces_in_gke["airflow_ns"].name
  airflow_config_values = var.airflow_config_values
  k8_cluster_configs    = var.k8_cluster_configs
  project               = module.gcp_services.project_id
  gke_details           = module.gke_cluster.gke_details
  pii_map_values        = var.pii_map_values
}

## Trino MPP
module "trino" {
  source               = "../../modules/trino"
  gke_cluster_name     = module.gke_cluster.cluster_name
  helm_version         = var.trino_helm_chart_version
  k8_cluster_configs   = var.k8_cluster_configs
  namespace            = var.namespaces_in_gke["trino_ns"].name
  configs              = var.trino_configs
  gke_details          = module.gke_cluster.gke_details
  thrift_metastore_uri = module.hive_metastore.dataproc_hive_metastore_cluster
}

