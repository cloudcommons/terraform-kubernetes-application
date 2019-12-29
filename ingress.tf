resource "kubernetes_ingress" "cloudcommons" {
  metadata {
    name = local.full_name
    annotations = var.INGRESS_ANNOTATIONS
    labels = var.LABELS
  }  

  spec {
    dynamic "backend" {
      for_each = var.SERVICE_ENABLED == true ? [1] : []
      content {
        service_name = local.service_name
        service_port = local.service_port
      }
    }

    rule {
      http {
        dynamic "path" {
          for_each = var.INGRESS_PATHS
          content {
            backend {
              service_name = path.value.service_name
              service_port = path.value.service_port
            }

            path = path.value.path
          }
        }
      }
    }

    dynamic "tls" {
      for_each = var.INGRESS_TLS != null ? [1] : []
      content {
        hosts       = var.INGRESS_TLS.hosts
        secret_name = var.INGRESS_TLS.secret_name
      }
    }
  }
}
