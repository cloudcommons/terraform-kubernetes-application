locals {
  service_name = kubernetes_service.cloudcommons[0].metadata[0].name
  service_port = kubernetes_service.cloudcommons[0].spec[0].port[0].port
}

resource "kubernetes_service" "cloudcommons" {
  count = var.SERVICE_ENABLED == true ? 1 : 0  
  metadata {
    name = local.full_name
    labels = {
      app         = local.full_name
      environment = local.environment
    }
  }

  spec {
    selector = {
      app         = kubernetes_deployment.cloudcommons.metadata[0].labels.app
      environment = kubernetes_deployment.cloudcommons.metadata[0].labels.environment
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
