data "google_client_config" "current" {}

resource "google_container_cluster" "gke-cluster-new" {
  provider = google-beta

  name     = var.cluster-name
  project  = var.project-name
  location = var.region-name

  network    = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.subnetwork.self_link

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  
  remove_default_node_pool = "true"
  initial_node_count       = 1

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }

    network_policy_config {
      disabled = false
    }

    http_load_balancing {
          disabled = false
     }
     istio_config {
           disabled = false
           auth     = "AUTH_NONE"
    }  
    
    horizontal_pod_autoscaling {
           disabled = false
    }
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = "false"
    }
  }

  workload_identity_config {
       identity_namespace  = "${data.google_client_config.current.project}.svc.id.goog"
  }


  ip_allocation_policy {
    use_ip_aliases                = true
    cluster_secondary_range_name  = google_compute_subnetwork.subnetwork.secondary_ip_range.0.range_name
    services_secondary_range_name = google_compute_subnetwork.subnetwork.secondary_ip_range.1.range_name
  }


  private_cluster_config {
    enable_private_endpoint = "true"
    enable_private_nodes    = "true"
    master_ipv4_cidr_block  = "172.16.0.16/28"
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}


resource "google_container_node_pool" "private-nodes" {
  provider = google-beta

  name       = var.pool 
  location   = var.region-name
  cluster    = google_container_cluster.gke-cluster-new.name
  node_count = "1"

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  node_config {
    machine_type = "g1-small"
  
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]

    labels = {
      cluster = var.cluster-name
    }

    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER"
    }

 }

 depends_on = [
   "google_container_cluster.gke-cluster-new",    
  ]

}


