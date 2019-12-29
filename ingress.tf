resource "kubernetes_ingress" "cloudcommons" {
  metadata {
    name        = local.full_name
    annotations = var.INGRESS_ANNOTATIONS
    labels      = var.LABELS
  }

  spec {
    dynamic "backend" {
      for_each = var.SERVICE_ENABLED == true ? [1] : [] # Default back-end
      content {
        service_name = kubernetes_service.cloudcommons[backend.key].metadata[0].name
        service_port = kubernetes_service.cloudcommons[backend.key].spec[0].port[0].port
      }
    }

    rule {
      http {
        dynamic "path" {
          for_each = var.SERVICE_ENABLED == true ? var.VERSIONS : []
          content {
            backend {
              service_name = kubernetes_service.cloudcommons[path.key].metadata[0].name
              service_port = kubernetes_service.cloudcommons[path.key].spec[0].port[0].port
            }

            path = path.value.path == null ? "/${path.value.docker_tag}" : path.value.path
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
