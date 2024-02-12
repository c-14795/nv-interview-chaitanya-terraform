variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "project" {
  description = "Name of the project"
  type        = string
}

variable "region" {
  description = "The GCP region for terraform space"
  type        = string
}

# limiting them to 1 for the scope of assessment,
# in general we can have a list of objects defined and gather the info from there

variable "vpc_name" {
  description = "The name of the vpc"
  type        = string
}

# limiting them to 1 for the scope of assessment,
# in general we can have a list of objects defined and gather the info from there
variable "subnet" {
  description = "The name of the subnet"
  type        = object({
    name       = string
    cidr_range = string
  })
}

variable "node_pools" {
  description = "List of node pools configurations for gke cluster"
  type        = list(object({
    name               = string
    machine_type       = string
    min_count          = number
    max_count          = number
    disk_size_gb       = number
    disk_type          = string
    initial_node_count = number

    # Add other necessary configurations for each node pool, kept minimal.
  }))
}

variable "namespaces" {
  type = map(object({
    name = string
  }))
  description = "list of namespaces to be created"
}