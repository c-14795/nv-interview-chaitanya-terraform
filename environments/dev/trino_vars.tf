variable "trino_helm_chart_version" {
  description = "Version of trino in helm provider"
  type        = string
}

variable "trino_configs" {
  description = "trino config files"
  type        = string
}

#variable "trino_replicas" {
#  type = number
#  description = "trino replicas"
#  default = 2
#}
#
#variable "trino_memory_requests" {
#  type = string
#  description = "trino memory requests"
#  default = "2Gi"
#}
#
#variable "trino_memory_limits" {
#  type = string
#  description = "trino memory limits"
#  default = "4Gi"
#}
variable "trino_namespace" {
  description = "namespace for trino"
  type        = string
}