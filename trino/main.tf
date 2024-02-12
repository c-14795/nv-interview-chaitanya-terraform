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
#    thrift_metastore_uri = var.thrift_metastore_uri
    })
    ,
  ]
}