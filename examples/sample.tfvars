APP_NAME            = "test"
DEPLOYMENT_REPLICAS = 1
DEPLOYMENT_IMAGE    = "test"
VERSIONS = [
  {
    name       = "v1-0"
    docker_tag = "v1.0"
    path       = null # Terraform doesn't support default value in objects. Null will make this script to automatically generate the path
  },
  {
    name       = "v1-1"
    docker_tag = "v1.1"
    path       = null
  }
]
DEPLOYMENT_IMAGE_PULL_REQUEST = "my-registry-secret"
DEPLOYMENT_SECRET_VOLUMES = [
  {
    name       = "settings"
    mount_path = "/app/config"
    read_only  = true
  }
]
LABELS = {
  mylabel = "myvalue"
}
NAMESPACE_ANNOTATIONS = {
  myannotation = "myvalue"
}
READINESS_PROBE = {
  path              = "/ready"
  port              = 100
  initial_delay     = 30
  period_seconds    = 10
  failure_threshold = null
}
LIVENESS_PROBE = {
  path              = "/live"
  port              = 101
  initial_delay     = 31
  period_seconds    = 11
  failure_threshold = null
}
SERVICE_PORT = 80
SERVICE_TYPE = "ClusterIP"
INGRESS_ANNOTATIONS = {
  "kubernetes.io/ingress.class" = "test-dev"
}
INGRESS_TLS = {
  hosts       = ["test.dev.local"]
  secret_name = "tls-secret"
}
