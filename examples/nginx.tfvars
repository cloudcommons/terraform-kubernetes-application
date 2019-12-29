APP_NAME            = "cloudcommons-nginx"
DEPLOYMENT_REPLICAS = 1
DEPLOYMENT_IMAGE    = "nginxdemos/hello"
ENV = {
  ENV1 = "value1"
  ENV2 = "value2"
}
VERSIONS = [
  {
    name = "latest"
    docker_tag = "latest"
    path       = "/"
  },
  {
    name = "v1.0"
    docker_tag = "latest"
    path       = "/v1.0"
  },
  {
    name = "v1.1"
    docker_tag = "latest"
    path       = "/v1.1"
  }     
]
SERVICE_PORT = 80
READINESS_PROBE = {
  initial_delay     = 5
  period_seconds    = 10
  failure_threshold = null
}
LIVENESS_PROBE = {
  initial_delay     = 5
  period_seconds    = 10
  failure_threshold = null
}
INGRESS_ANNOTATIONS = {
  "kubernetes.io/ingress.class" = "nginx"
}
