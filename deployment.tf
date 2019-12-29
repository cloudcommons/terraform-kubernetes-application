resource "kubernetes_deployment" "cloudcommons" {
  count = length(var.VERSIONS)
  metadata {
    name      = "${local.full_name}-${var.VERSIONS[count.index].docker_tag}"
    namespace = local.namespace
    labels = {
      app         = local.full_name
      version     = var.VERSIONS[count.index].docker_tag
      environment = local.environment
    }
  }

  spec {
    replicas = var.DEPLOYMENT_REPLICAS
    selector {
      match_labels = {
        app         = local.full_name
        version     = var.VERSIONS[count.index].docker_tag
        environment = local.environment
      }
    }

    template {
      metadata {
        labels = {
          app         = local.full_name
          version     = var.VERSIONS[count.index].docker_tag
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
        # TODO This strategy support secret mounts only. Find a way to support all (or more) mount types
        dynamic "volume" {
          for_each = var.DEPLOYMENT_SECRET_VOLUMES
          content {
            secret {
              secret_name = volume.value.name
            }
          }
        }

        container {
          image = "${var.DEPLOYMENT_IMAGE}:${var.VERSIONS[count.index].docker_tag}"
          name  = "${local.full_name}-${var.VERSIONS[count.index].docker_tag}"

          dynamic "volume_mount" {
            for_each = var.DEPLOYMENT_SECRET_VOLUMES
            content {
              name       = volume_mount.value.name
              mount_path = volume_mount.value.mount_path
              read_only  = volume_mount.value.read_only
            }
          }

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
            for_each = var.LIVENESS_PROBE != null ? [var.LIVENESS_PROBE] : []
            content {
              http_get {
                path = liveness_probe.value.path
                port = liveness_probe.value.port
              }

              initial_delay_seconds = liveness_probe.value.initial_delay
              period_seconds        = liveness_probe.value.period_seconds
              failure_threshold     = liveness_probe.value.failure_threshold
            }
          }

          dynamic "readiness_probe" {
            for_each = var.READINESS_PROBE != null ? [var.READINESS_PROBE] : []
            content {
              http_get {
                path = readiness_probe.value.path
                port = readiness_probe.value.port
              }

              initial_delay_seconds = readiness_probe.value.initial_delay
              period_seconds        = readiness_probe.value.period_seconds
              failure_threshold     = readiness_probe.value.failure_threshold
            }
          }
        }
      }
    }
  }
}
