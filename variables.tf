variable "APP_NAME" {
  type        = string
  description = "(Required) Application name"
}

variable "UID" {
  type = string
  description = "(Required) A unique identifier to attach to the namespace"
}

variable "DEPLOYMENTS" {
  type = list(object({
    hostname     = string
    name         = string
    path         = string
    docker_image = string
    docker_tag   = string
  }))
  description = "(Required) List of backends to deploy, and routes to get to them"
  default = [{
    hostname     = null
    name         = "latest"
    path         = null
    docker_image = null
    docker_tag   = "latest"
  }]
}

variable "ENV" {
  type        = map(string)
  description = "(Optional) Deployment environment variables"
  default     = {}
}

variable "DEPLOYMENT_IMAGE_PULL_SECRET" {
  type        = string
  description = " (Optional) ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec. If specified, these secrets will be passed to individual puller implementations for them to use. For example, in the case of docker, only DockerConfig type secrets are honored. For more info see Kubernetes reference"
  default     = null
}

variable "DEPLOYMENT_IMAGE_PULL_POLICY" {
  type        = string
  description = "(Optional) Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. For more info see Kubernetes reference"
  default     = "Always"
}


# TODO This strategy support secret mounts only. Find a way to support all (or more) mount types
variable "DEPLOYMENT_SECRET_VOLUMES" {
  type = list(object({
    name       = string
    mount_path = string
    sub_path   = string
    read_only  = bool
  }))
  default = []
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

variable "LIVENESS_PROBE" {
  type = object({
    initial_delay     = number
    period_seconds    = number
    failure_threshold = number
  })
  description = "(Optional) Application liveness probe"
  default     = null
}

variable "READINESS_PROBE" {
  type = object({
    initial_delay     = number
    period_seconds    = number
    failure_threshold = number
  })
  description = "(Optional) Application readyness probe"
  default     = null
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
  type = list(object({
    hosts       = list(string)
    secret_name = string
  }))
  description = "(Optional) TLS configuration for the Ingress. Default to null"
  default     = []
}

variable "INGRESS_DEFAULT_BACKEND_ENABLED" {
  type        = bool
  description = "(Optional) Disables the default back-end for the ingress. Defaults to false. If true, the first version defined in DEPLOYMENTS will be used as default back-end"
  default     = false
}
