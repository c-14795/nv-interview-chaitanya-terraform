variable "gke_cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The GCP region for terraform space"
  type        = string
}

variable "project" {
  description = "The GCP project for terraform space"
  type        = string
}

## in general this should not be in the configs,
# as a best practice we should read it from env variables / vault and store it for the CD purpose and destroy it.
#but for assessment scope keeping this in config
variable "creds" {
  description = "creds for gcp"
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

variable "gke_node_pools" {
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
variable "namespaces_in_gke" {
  type = map(object({
    name = string
  }))
  description = "list of namespaces to be created in GKE cluster"
}

variable "services_to_be_enabled" {
  type = list(string)
  description = "list of services to be enabled before proceeding and disabled post destroying"
}


