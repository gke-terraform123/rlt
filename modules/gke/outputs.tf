output "host" {
  value     = "${google_container_cluster.gke-cluster.endpoint}"
 }


output "gke-cluster-name" {
  value       = google_container_cluster.gke-cluster.name
}
