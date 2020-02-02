resource "kubernetes_service" "cloudcommons" {
  count = var.SERVICE_ENABLED == true ? length(var.DEPLOYMENTS) : 0
  metadata {
    name = "${local.full_name}-${replace(var.DEPLOYMENTS[count.index].name, ".", "-")}"
    namespace = local.namespace
    labels = {
      app         = local.full_name
      version     = var.DEPLOYMENTS[count.index].name
      environment = local.environment
    }
  }

  spec {
    selector = {
        app         = local.full_name
        version     = var.DEPLOYMENTS[count.index].name
        environment = local.environment
    }

    session_affinity = var.SERVICE_SESSION_AFFINITY
    port {
      port        = var.SERVICE_PORT
      target_port = var.SERVICE_TARGET_PORT == null ? var.SERVICE_PORT : var.SERVICE_TARGET_PORT
      protocol    = var.SERVICE_PROTOCOL
    }

    type = var.SERVICE_TYPE
  }
}
