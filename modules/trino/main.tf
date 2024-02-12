provider "helm" {
  kubernetes {
#        config_path = var.k8_cluster_configs  # Path to your kubeconfig file

    host                   = var.gke_details.host
    cluster_ca_certificate = var.gke_details.ca_cert
    token                  = var.gke_details.token
  }
}

resource "helm_release" "trino" {
  name       = "trino"
  repository = "https://trinodb.github.io/charts"
  chart      = "trino"
  version    = var.helm_version
  namespace = var.namespace
  wait = true
    values           = [
    templatefile(var.configs, {
    thrift_metastore_uri = var.thrift_metastore_uri
    })
    ,
  ]
  depends_on = [module.trino-ns-workload-identity]
}
provider "kubernetes" {
  host                   = var.gke_details.host
  cluster_ca_certificate = var.gke_details.ca_cert
  token                  = var.gke_details.token
}

module "trino-ns-workload-identity" {
  source       = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  version      = "30.0.0"
  use_existing_gcp_sa = true
  name= "sa-nv-interview-chaitanya"
  k8s_sa_name= "sa-nv-interview-chaitanya-k8-trino"
  namespace    = var.namespace
  project_id   = var.project
  cluster_name = var.gke_cluster_name
  annotate_k8s_sa = true
  roles        = [
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
}