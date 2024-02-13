provider "helm" {

  kubernetes {
    #    config_path = var.k8_cluster_configs  # Path to your kubeconfig file

    host                   = var.gke_details.host
    cluster_ca_certificate = var.gke_details.ca_cert
    token                  = var.gke_details.token
  }
}

provider "kubernetes" {
  host                   = var.gke_details.host
  cluster_ca_certificate = var.gke_details.ca_cert
  token                  = var.gke_details.token
}

resource "helm_release" "airflow" {
  #  count = var.deploy_airflow ? 1 : 0

  name       = "airflow"
  chart      = "airflow"
  repository = "https://airflow.apache.org"
  version    = var.helm_version
  namespace  = var.namespace
  #  gke_cluster_name = var.gke_cluster_name
  #  gke
  values     = [
    templatefile(var.airflow_config_values, {}),
  ]


  wait = false
  set {
    name  = "defaultAirflowTag"
    value = var.default_tag
  }
  set {
    name  = "executor"
    value = var.executor
  }

}

module "airflow-ns-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#  version             = var.wke_gcp_module_version
  version             = "30.0.0"
  use_existing_gcp_sa = true
  name                = var.existing_sa
  k8s_sa_name         = "sa-nv-interview-chaitanya-k8"
  namespace           = var.namespace
  project_id          = var.project
  cluster_name        = var.gke_cluster_name
  annotate_k8s_sa     = true
  roles               = [
    "roles/storage.admin",
    "roles/compute.admin",
    "roles/dataproc.admin",
    "roles/metastore.admin",
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountAdmin",
    "roles/container.admin"
  ]
  providers = {
    kubernetes = kubernetes
  }
  use_existing_context = true
  module_depends_on    = [helm_release.airflow]
}

resource "kubernetes_config_map" "pii_map" {
  metadata {
    name      = "pii-config"
    namespace = var.namespace
  }
  data = {
    "data" = file(var.pii_map_values)
  }
}