resource "google_compute_address" "nat_ip" {
  name    = "nat-ip"
  project = var.project-name
  region  = var.region-name
}


resource "google_compute_router" "router" {
  name    = "cloud-router"
  project = var.project-name
  region  = var.region-name
  network = google_compute_network.vpc.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name    = "cloud-nat"
  project = var.project-name
  router  = google_compute_router.router.name
  region  = var.region-name

  nat_ip_allocate_option = "MANUAL_ONLY"

  nat_ips = [google_compute_address.nat_ip.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnetwork.self_link
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE", "LIST_OF_SECONDARY_IP_RANGES"]

    secondary_ip_range_names = [
      google_compute_subnetwork.subnetwork.secondary_ip_range.0.range_name,
      google_compute_subnetwork.subnetwork.secondary_ip_range.1.range_name,
    ]
  }
}
