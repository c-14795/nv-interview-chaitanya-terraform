variable "helm_version" {
  description = "Version of trino in helm provider"
  type        = string
}

variable "namespace" {
  description = " trino namespace in kubernetes cluster"
  type        = string
}

variable "gke_cluster_name" {
  type        = string
  description = "gke_cluster_name"
}

variable "k8_cluster_configs" {
  description = "k8 cluster config files"
  type        = string
}

variable "configs" {
  description = "trino config files"
  type        = string
}

variable "trino_replicas" {
  type        = number
  description = "trino replicas"
  default     = 2
}

variable "trino_memory_requests" {
  type        = string
  description = "trino memory requests"
  default     = "2Gi"
}

variable "trino_memory_limits" {
  type        = string
  description = "trino memory limits"
  default     = "4Gi"
}

variable "thrift_metastore_uri" {
  type        = string
  description = "metastore uri"
}

variable "gke_details" {
  description = "The GCP project for terraform space"
  type        = map(string)
}
variable "project" {
  description = "The GCP project for terraform space"
  type        = string
}