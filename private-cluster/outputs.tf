output "nat_ip_address" {
  value = google_compute_address.nat_ip.address
}

output "cluster_ca_certificate" {
  sensitive   = true
  value       = google_container_cluster.gke-cluster-new.master_auth[0].cluster_ca_certificate
}

output "credentials" {
  value       = format("gcloud container clusters get-credentials --project %s --region %s --internal-ip %s", var.project-name, var.region-name, var.cluster-name)
}  
  
