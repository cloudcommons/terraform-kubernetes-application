APP_NAME         = "test"
DEPLOYMENT_IMAGE = "test:latest"
DEPLOYMENT_IMAGE_PULL_REQUEST = "my-registry-secret"
LABELS = {
  mylabel = "myvalue"
}
NAMESPACE_ANNOTATIONS = {
  myannotation = "myvalue"
}
LIVENESS_PROBE_PATH      = "/"
SERVICE_PORT             = 80
SERVICE_TYPE             = "LoadBalancer"
SERVICE_LOAD_BALANCER_IP = "172.16.1.3"
INGRESS_ANNOTATIONS = {
  "kubernetes.io/ingress.class" = "tdp-dev"
}
INGRESS_PATHS = [
    {
        path = "/v1.0"
        service_name = "test-v1.0"
        service_port = 80
    },
    {
        path = "/v1.1"
        service_name = "test-v1.1"
        service_port = 80
    }    
]
INGRESS_TLS = {
    hosts = ["test.dev.local"]
    secret_name = "tls-secret"
}
