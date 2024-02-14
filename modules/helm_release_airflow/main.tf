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


resource "helm_release" "airflow-helm" {
  #  count = var.deploy_airflow ? 1 : 0

  name       = "airflow-helm"
  chart      = "airflow"
  repository = "https://airflow-helm.github.io/charts"
  version    = var.helm_version
  namespace  = var.namespace
  #  gke_cluster_name = var.gke_cluster_name
  #  gke
  values     = [
    templatefile(var.airflow_config_values, {
      pii_map_mount_path = var.pii_map_mount_path
    }),
  ]
  wait = false

  depends_on = [module.airflow-ns-workload-identity]

}

module "airflow-ns-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#  version             = var.wke_gcp_module_version
  version             = "30.0.0"
  use_existing_gcp_sa = true
  name                = var.existing_sa
  k8s_sa_name         = "sa-nv-interview-chaitanya-k8-airflow"
  namespace           = var.namespace
  project_id          = var.project
  cluster_name        = var.gke_cluster_name
  annotate_k8s_sa     = true
  providers = {
    kubernetes = kubernetes
  }
  use_existing_context = true
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