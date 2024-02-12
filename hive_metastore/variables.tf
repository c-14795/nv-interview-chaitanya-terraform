variable "meta_store_cluster_name" {
  type = string
  description = "hive meta store cluster name"
}
variable "region" {
  type = string
  description = "region to be cluster on"
}
variable "project_id" {
  type = string
  description = "project id"
}
variable "hive_metastore_bucket" {
  type = string
  description = "hive metastore bucket"
}