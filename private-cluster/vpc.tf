resource "google_compute_network" "vpc" {
  name                    = var.vpc-name
  project                 = var.project-name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork-name
  project       = var.project-name
  network       = google_compute_network.vpc.self_link
  region        = var.region-name
  ip_cidr_range = "10.0.0.0/24"

  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.pod-net
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = var.svc-net
    ip_cidr_range = "10.2.0.0/20"
  }
}
