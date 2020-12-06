resource "kubernetes_ingress" "rlt_ingress" {
  metadata {
    name = "rlt-ingress"

    annotations = {
        "ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    backend {
      service_name = "rlt"
      service_port = 80
    }

    rule {
      http {
        path {
          backend {
            service_name = "rlt-new"
            service_port = 80
          }
          path = "/*"
        }

        path {
          backend {
            service_name = "rlt"
            service_port = 80
          }
          path = "/rlt*"
        }
      }
    }
  }
}
