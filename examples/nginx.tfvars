APP_NAME            = "cloudcommons-nginx"
DEPLOYMENT_REPLICAS = 1
ENV = {
  ENV1 = "value1"
  ENV2 = "value2"
}
DEPLOYMENTS = [
  {
    hostname     = null
    name         = "latest"
    docker_image = "nginxdemos/hello"
    docker_tag   = "latest"
    path         = "/"
  },
  {
    hostname     = null
    name         = "v1.0"
    docker_image = "nginxdemos/hello"
    docker_tag   = "latest"
    path         = "/v1.0"
  },
  {
    hostname     = null
    name         = "v1.1"
    docker_image = "nginxdemos/hello"
    docker_tag   = "latest"
    path         = "/v1.1"
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
# INGRESS_TLS = {
#   hosts = ["my.nginx.local"]
#   secret_name = "my-tls-secrets"
# }
