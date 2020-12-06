
resource "google_container_cluster" "gke-cluster" {
  name                        = var.cluster-name
  location                    = var.region-name
  provider                    = google-beta

  remove_default_node_pool    = true
  initial_node_count          = 1


  network                     = "default"
  subnetwork                  = "default"

  master_auth {
    username                  = ""
    password                  = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  logging_service            = "logging.googleapis.com/kubernetes"
  monitoring_service         = "monitoring.googleapis.com/kubernetes"

  lifecycle {
    create_before_destroy = true

    ignore_changes = [
           node_config, 
          ]
  }

  network_policy {
       enabled = true
  }
  

  timeouts {
       create = "30m"
       update = "30m"
       delete = "30m"
  }
  
  addons_config {

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

    network_policy_config {
          disabled = false
    }
    
  }

}

resource "google_container_node_pool" "nodes" {

  name                        = "cluster-nodes"
  location                    = var.region-name
  cluster                     = google_container_cluster.gke-cluster.name

  initial_node_count = "1"

  autoscaling {
    min_node_count            = "1"
    max_node_count            = "3"
  }

  management {
    auto_repair               = "true"
    auto_upgrade              = "true"
  }

  node_config {
    image_type                = "Ubuntu"
    machine_type              = "g1-small"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  lifecycle {
    ignore_changes            = [initial_node_count]
  }

  timeouts {
    create                    = "30m"
    update                    = "30m"
    delete                    = "30m"
  }
}
