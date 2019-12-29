resource "kubernetes_namespace" "cloudcommons" {
  metadata {
    name = "${var.APP_NAME}-${local.environment}"
    annotations = var.NAMESPACE_ANNOTATIONS
    labels = var.LABELS    
  }
}