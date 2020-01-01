resource "kubernetes_ingress" "cloudcommons" {
  metadata {
    name        = local.full_name
    namespace   = local.namespace
    annotations = var.INGRESS_ANNOTATIONS
    labels      = var.LABELS
  }

  spec {
    dynamic "backend" {
      for_each = var.SERVICE_ENABLED == true && var.INGRESS_DEFAULT_BACKEND_ENABLED == true ? [1] : [] # Default back-end
      content {
        service_name = kubernetes_service.cloudcommons[backend.key].metadata[0].name
        service_port = kubernetes_service.cloudcommons[backend.key].spec[0].port[0].port
      }
    }

    dynamic "rule" {
      for_each = var.SERVICE_ENABLED == true ? var.VERSIONS : []
      content {
        host = rule.value.hostname
        http {
          path {
            backend {
              service_name = kubernetes_service.cloudcommons[rule.key].metadata[0].name
              service_port = kubernetes_service.cloudcommons[rule.key].spec[0].port[0].port
            }

            path = rule.value.path == null ? "/${rule.value.docker_tag}" : rule.value.path
          }
        }
      }
    }

    dynamic "tls" {
      for_each = var.INGRESS_TLS
      content {
        hosts       = tls.value.hosts
        secret_name = tls.value.secret_name
      }
    }
  }
}
