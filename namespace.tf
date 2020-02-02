locals {
  namespace = kubernetes_namespace.cloudcommons.metadata[0].name
}

resource "kubernetes_namespace" "cloudcommons" {
  metadata {
    name = "${var.APP_NAME}-${local.environment}-${var.UID}"
    annotations = var.NAMESPACE_ANNOTATIONS
    labels = var.LABELS    
  }
}