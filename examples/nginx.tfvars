APP_NAME            = "cloudcommons-nginx"
DEPLOYMENT_REPLICAS = 1
DEPLOYMENT_IMAGE    = "nginx"
VERSIONS = [
  {
    docker_tag = "latest"
    path       = "/"
  }
]
SERVICE_PORT = 80
READINESS_PROBE = {
  path              = "/"
  port              = 80
  initial_delay     = 30
  period_seconds    = 10
  failure_threshold = null
}
LIVENESS_PROBE = {
  path              = "/"
  port              = 80
  initial_delay     = 30
  period_seconds    = 10
  failure_threshold = null
}
INGRESS_ANNOTATIONS = {
  "kubernetes.io/ingress.class" = "cloudcommons-test"
}
