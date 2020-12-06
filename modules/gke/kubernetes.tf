resource "kubernetes_deployment" "test" {
  for_each = toset(["rlt","rlt-new"])
  
  metadata {
    name = each.key
 }

  spec {
    selector {
      match_labels = {
        app = each.key
      }
    }

  
    template {
      metadata {
        labels = {
          app = each.key
        }
      }
      spec {
        container {
          image = "gcr.io/${var.project-name}/rlt-test:latest"
          name  = each.key

          port {
            container_port = 80
          }
        }
      }
    }
  }
  depends_on = [
    google_container_cluster.gke-cluster,
    google_container_node_pool.nodes
  ]
}

resource "kubernetes_service" "rlt-service" {
  for_each = toset(["rlt","rlt-new"])
  
  metadata {
    name = each.key
  }
  spec {
    selector = {
      app = each.key
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
   depends_on = [
     google_container_cluster.gke-cluster,
     google_container_node_pool.nodes
  ]
}



