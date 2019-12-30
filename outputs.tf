output "name" {
  description = "Application full name"
  value = local.full_name
}

output "namespace" {
  description = "Namespace created for this application"
  value       = local.namespace
}

output "deployments" {
  description = "List of deployment names created"
  value       = kubernetes_deployment.cloudcommons[*].metadata[0].name
}

output "services" {
  description = "List of service names created"
  value       = kubernetes_service.cloudcommons[*].metadata[0].name
}

output "ingress" {
  description = "Ingress name creates"
  value       = kubernetes_ingress.cloudcommons.metadata[0].name
}