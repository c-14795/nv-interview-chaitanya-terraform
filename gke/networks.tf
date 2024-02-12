resource "google_compute_network" "vpc" {
  #  name                    = "${var.project_id}-vpc"
  name                    = "${var.vpc_name}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_name}-${var.subnet.name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.subnet.cidr_range
  #  subnet_private_access = false
  # "10.10.0.0/24"
  # "10.2.0.0/16"
}
resource "google_compute_firewall" "allow_internet" {
  name    = "allow-internet"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]  # Example ports for outbound internet access
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internet"]
}
resource "google_compute_router" "router" {
  name    = "gke-router"
  network = google_compute_network.vpc.self_link
  region = var.region
}
resource "google_compute_router_nat" "cloud_nat" {
  name                               = "gke-cloud-nat"
  router                             = google_compute_router.router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  region = var.region
}

# Allow all inbound traffic to the default VPC network.
resource "google_compute_firewall" "allow-all-inbound" {
  name    = "allow-all-inbound"
  network = "default"

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internet"]
}

# Allow all outbound traffic from the default VPC network.
resource "google_compute_firewall" "allow-all-outbound" {
  name    = "allow-all-outbound"
  network = "default"

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  destination_ranges = ["0.0.0.0/0"]
}