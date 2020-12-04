resource "kubernetes_deployment" "test" {
  metadata {
    name = "rlt-new"
 }

  spec {
    selector {
      match_labels = {
        app = "rlt"
      }
    }

  
    template {
      metadata {
        labels = {
          app = "rlt"
        }
      }
      spec {
        container {
          image = "gcr.io/${var.project-name}/rlt-test:latest"
          name  = "rlt"

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

resource "kubernetes_service" "nginx" {
  metadata {
    name = kubernetes_deployment.test.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata[0].labels.app
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



