variable "airflow_tag" {
  type        = string
  description = "Tag for airflow in k8"
}
variable "airflow_executor" {
  description = "Type of executor to use in airflow"
  type        = string
}
variable "airflow_helm_chart_version" {
  description = "Airflow helm chart version"
  type        = string
}
variable "airflow_k8_namespace" {
  description = "airflow name space in kubernets"
  type        = string
}
variable "airflow_config_values" {
  description = "airflow config values"
  type        = string
}
variable "pii_map_mount_path" {
  description = "k8 cluster config files"
  type        = string
}
variable "pii_map_values" {
  description = "pii map values"
  type        = string
}