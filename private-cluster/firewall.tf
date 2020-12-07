 # SSH rule for IAP
resource "google_compute_firewall" "iap-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  direction = "INGRESS"
  priority  = 1000

  # Cloud IAP's TCP forwarding netblock
  source_ranges = ["35.235.240.0/20"]


  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
