resource "kubernetes_deployment" "cloudcommons" {
  count = length(var.DEPLOYMENTS)
  metadata {
    name      = "${local.full_name}-${replace(var.DEPLOYMENTS[count.index].name, ".", "-")}"
    namespace = local.namespace
    labels = {
      app         = local.full_name
      version     = var.DEPLOYMENTS[count.index].name
      environment = local.environment
    }
  }

  spec {
    replicas = var.DEPLOYMENT_REPLICAS
    selector {
      match_labels = {
        app         = local.full_name
        version     = var.DEPLOYMENTS[count.index].name
        environment = local.environment
      }
    }

    template {
      metadata {
        labels = {
          app         = local.full_name
          version     = var.DEPLOYMENTS[count.index].name
          environment = local.environment
        }
      }

      spec {
        dynamic "image_pull_secrets" {
          for_each = var.DEPLOYMENT_IMAGE_PULL_SECRET != null ? [1] : []
          content {
            name = var.DEPLOYMENT_IMAGE_PULL_SECRET
          }
        }
        # TODO This strategy support secret mounts only. Find a way to support all (or more) mount types
        dynamic "volume" {
          for_each = var.DEPLOYMENTS[count.index].volume_mounts
          content {
            secret {
              secret_name = volume.value.name
            }
          }
        }

        container {
          name              = "${local.full_name}-${replace(var.DEPLOYMENTS[count.index].name, ".", "-")}"
          image             = "${var.DEPLOYMENTS[count.index].docker_image}:${var.DEPLOYMENTS[count.index].docker_tag}"
          image_pull_policy = var.DEPLOYMENT_IMAGE_PULL_POLICY

          dynamic "env" {
            for_each = var.ENV
            content {
              name  = env.key
              value = env.value
            }
          }

          dynamic "volume_mount" {
            for_each = var.DEPLOYMENTS[count.index].volume_mounts
            content {
              name       = volume_mount.value.name
              mount_path = volume_mount.value.mount_path
              sub_path   = volume_mount.value.sub_path
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
                path = var.DEPLOYMENTS[count.index].path
                port = var.SERVICE_PORT
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
                path = var.DEPLOYMENTS[count.index].path
                port = var.SERVICE_PORT
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
