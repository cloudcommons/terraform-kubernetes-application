resource "kubernetes_deployment" "cloudcommons" {
  metadata {
    name = local.full_name
    labels = {
      app         = local.full_name
      environment = local.environment
    }
  }

  spec {
    replicas = var.DEPLOYMENT_REPLICAS
    selector {
      match_labels = {
        app         = local.full_name
        environment = local.environment
      }
    }

    template {
      metadata {
        labels = {
          app         = local.full_name
          environment = local.environment
        }
      }

      spec {
        dynamic "image_pull_secrets" {
          for_each = var.DEPLOYMENT_IMAGE_PULL_REQUEST != null ? [1] : []
          content {
            name = var.DEPLOYMENT_IMAGE_PULL_REQUEST
          }
        }

        container {
          image = var.DEPLOYMENT_IMAGE
          name  = local.full_name

          resources {
            dynamic "limits" {
              for_each = var.DEPLOYMENT_RESOURCE_LIMITS != null ? [1] : []
              content {
                cpu    = var.DEPLOYMENT_RESOURCE_LIMITS.cpu
                memory = var.DEPLOYMENT_RESOURCE_LIMITS.memory
              }
            }

            dynamic "requests" {
              for_each = var.DEPLOYMENT_RESOURCE_REQUESTS != null ? [1] : []
              content {
                cpu    = var.DEPLOYMENT_RESOURCE_REQUESTS.cpu
                memory = var.DEPLOYMENT_RESOURCE_REQUESTS.memory
              }
            }
          }

          dynamic "liveness_probe" {
            for_each = var.LIVENESS_PROBE_PATH != null ? [1] : []
            content {
              http_get {
                path = var.LIVENESS_PROBE_PATH
                port = var.LIVENESS_PROBE_PORT
              }

              initial_delay_seconds = var.LIVENESS_PROBE_INITIAL_DELAY
              period_seconds        = var.LIVENESS_PROBE_PERIOD
            }
          }
        }
      }
    }
  }
}
