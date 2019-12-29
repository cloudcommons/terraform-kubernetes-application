APP_NAME         = "test"
DEPLOYMENT_IMAGE = "test"
VERSIONS = [
  {
    docker_tag = "v1.0"
    path       = null # Terraform doesn't support default value in objects. Null will make this script to automatically generate the path
  },
  {
    docker_tag = "v1.1"
    path       = null
  }
]
DEPLOYMENT_IMAGE_PULL_REQUEST = "my-registry-secret"
LABELS = {
  mylabel = "myvalue"
}
NAMESPACE_ANNOTATIONS = {
  myannotation = "myvalue"
}
LIVENESS_PROBE_PATH      = "/"
SERVICE_PORT             = 80
SERVICE_TYPE             = "ClusterIP"
INGRESS_ANNOTATIONS = {
  "kubernetes.io/ingress.class" = "test-dev"
}
INGRESS_TLS = {
  hosts       = ["test.dev.local"]
  secret_name = "tls-secret"
}
