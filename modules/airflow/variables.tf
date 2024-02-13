variable "helm_version" {
  description = "Version of airflow in helm provider"
  type        = string
}

variable "default_tag" {
  description = "The tag name for airflow jobs"
  type        = string
}


variable "executor" {
  description = "Type of executor in airflow"
  type        = string
}

variable "namespace" {
  description = "airflow namespace in kubernetes cluster"
  type        = string
}


variable "logging_bucket" {
  type        = string
  description = "Airflow logging bucket"
  default     = null
}

variable "logging_bucket_location" {
  type        = string
  description = "Location of the bucket in which to store the Airflow logs"
  default     = "US"
}

variable "airflow_logging_sa" {
  type        = string
  description = "Service account with access to airflow's logging bucket"
  default     = null
}

variable "gke_cluster_name" {
  type        = string
  description = "gke_cluster_name"
}
variable "airflow_config_values" {
  description = "airflow config values"
  type        = string
}
variable "k8_cluster_configs" {
  description = "k8 cluster config files"
  type        = string
}

variable "project" {
  description = "The GCP project for terraform space"
  type        = string
}
variable "gke_details" {
  description = "The GCP project for terraform space"
  type        = map(string)
}
variable "pii_map_values" {
  description = "pii map values"
  type        = string
}
variable "existing_sa" {
  description = "existing sa for work load federation"
  type        = string
}

variable "wke_gcp_module_version" {
  type = string
  description = "version for this module - https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/ "

}

#variable "k8_host" {
#  description = "gke cluster ip"
#  type        = string
#}
#variable "k8_ca_cert" {
#  description = "gke cluster cert"
#  type        = string
#}
#variable "k8_token" {
#  description = "gke cluster token"
#  type        = string
#}
