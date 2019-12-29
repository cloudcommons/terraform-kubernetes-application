variable "APP_NAME" {
  type        = string
  description = "(Required) Application name"
}

variable "DEPLOYMENT_IMAGE" {
  type        = string
  description = "(Required) Deployment Docker Image, including private registry, when required. Do not include tag"
}

variable "VERSIONS" {
  type = list(object({
    path       = string
    docker_tag = string
  }))
  description = "(Optional) List of Ingress path rules"
  default = [{
    path       = null
    docker_tag = "latest"
  }]
}

variable "DEPLOYMENT_IMAGE_PULL_REQUEST" {
  type        = string
  description = " (Optional) ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. For more info see Kubernetes reference"
  default     = null
}


variable "DEPLOYMENT_REPLICAS" {
  type        = number
  description = "(Optional) Number of deployment replicas. Defaults to 1"
  default     = 1
}

variable "DEPLOYMENT_RESOURCE_LIMITS" {
  type = object({
    cpu    = string
    memory = string
  })
  description = "(Optional) Deployment resource limits. Defaults to cpu (0.5) and memory (512Mi)"
  default = {
    cpu    = "0.5"
    memory = "512Mi"
  }
}

variable "DEPLOYMENT_RESOURCE_REQUESTS" {
  type = object({
    cpu    = string
    memory = string
  })
  description = "(Optional) Deployment resource requests. Defaults to cpu (250m) and memory (50Mi)"
  default = {
    cpu    = "250m"
    memory = "50Mi"
  }
}

variable "DEPLOYMENT_LIVENESS_PROBE" {
  type = object({
    path = string
    port = number
  })
  description = "(Optional) Deployment liveness probe"
  default     = null
}

variable "ENVIRONMENT" {
  type        = string
  description = "(Optional) Application environment"
  default     = null
}

variable "ANNOTATIONS" {
  type        = map(string)
  description = "(Optional) Application annotations"
  default     = {}
}

variable "LABELS" {
  type        = map(string)
  description = "(Optional) Application labels"
  default     = {}
}

variable "NAMESPACE_ANNOTATIONS" {
  type        = map(string)
  description = "(Optional) Namespace annotations"
  default     = {}
}

variable "LIVENESS_PROBE_PATH" {
  type        = string
  description = "(Optional) If specified, creates a liveness probe to the given path."
  default     = null
}

variable "LIVENESS_PROBE_PORT" {
  type        = number
  description = "(Optional) Liveness probe port. Defaults to 80"
  default     = 80
}

variable "LIVENESS_PROBE_INITIAL_DELAY" {
  type        = number
  description = "(Optional) Liveness probe initial delay, in seconds. Defualt to 30"
  default     = 30
}

variable "LIVENESS_PROBE_PERIOD" {
  type        = number
  description = "(Optional) Liveness probe period after initialisation, in seconds. Defualt to 10"
  default     = 10
}

variable "SERVICE_SESSION_AFFINITY" {
  type        = string
  description = "(Optional) Used to maintain session affinity. Supports ClientIP and None. Defaults to None. For more info see Kubernetes reference."
  default     = "None"
}

variable "SERVICE_ENABLED" {
  type        = bool
  description = "(Optional) Creates a service for this deployment. Defaults to true"
  default     = true
}

variable "SERVICE_PROTOCOL" {
  type        = string
  description = "(Optional) The IP protocol for this port. Supports TCP and UDP. Default is TCP."
  default     = "TCP"
}

variable "SERVICE_PORT" {
  type        = number
  description = "(Required) The port that will be exposed by this service."
}

variable "SERVICE_TARGET_PORT" {
  type        = number
  description = "(Optional) Number or name of the port to access on the pods targeted by the service. Number must be in the range 1 to 65535. This field is ignored for services with cluster_ip = 'None'. For more info see Kubernetes reference"
  default     = null
}

variable "SERVICE_TYPE" {
  type        = string
  description = "(Optional) Determines how the service is exposed. Defaults to ClusterIP. Valid options are ExternalName, ClusterIP, NodePort, and LoadBalancer. ExternalName maps to the specified external_name. For more info see Kubernetes reference"
  default     = "ClusterIP"
}

variable "SERVICE_LOAD_BALANCER_IP" {
  type        = string
  description = "(Optional) Only applies to type = LoadBalancer. LoadBalancer will get created with the IP specified in this field. This feature depends on whether the underlying cloud-provider supports specifying this field when a load balancer is created. This field will be ignored if the cloud-provider does not support the feature."
  default     = null
}


variable "INGRESS_ANNOTATIONS" {
  type        = map(string)
  description = "(Optional) Namespace annotations"
  default     = {}
}

variable "INGRESS_TLS" {
  type = object({
    hosts       = list(string)
    secret_name = string
  })
  description = "(Optional) TLS configuration for the Ingress. Default to null"
  default     = null
}

variable "INGRESS_DEFAULT_BACKEND_ENABLED" {
  type        = bool
  description = "(Optional) Disables the default back-end for the ingress. Defaults to false. If true, the first version defined in VERSIONS will be used as default back-end"
  default     = false
}
