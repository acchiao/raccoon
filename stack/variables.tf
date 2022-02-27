variable "environment" {
  description = "The project environment."
  type        = string
}

variable "release" {
  description = "The project release track."
  type        = string
}

variable "project_name" {
  description = "The DigitalOcean project name."
  type        = string
}

variable "project_environment" {
  description = "The DigitalOcean project environment. The possible values are: `Development`, `Staging`, `Production`."
  type        = string
  default     = "Production"
}

variable "region" {
  description = "See `doctl kubernetes options regions`."
  type        = string
  default     = "nyc1"
}

variable "cluster_size" {
  description = "See `doctl kubernetes options sizes`."
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "node_count" {
  description = "The number of Droplet instances in the node pool."
  type        = number
  default     = 1
}

variable "auto_scale" {
  description = "Enable auto-scaling for the Kubernetes cluster within given min/max node range."
  type        = bool
  default     = true
}

variable "min_nodes" {
  description = "If auto-scaling is enabled, this represents the minimum number of nodes that the node pool can be scaled down to."
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "If auto-scaling is enabled, this represents the maximum number of nodes that the node pool can be scaled up to."
  type        = number
  default     = 1
}

variable "digitalocean_domain" {
  description = "The name of the DigitalOcean domain resource."
  type        = string
  default     = ""
}

variable "cloudflare_domain" {
  description = "The name of the Cloudflare domain resource."
  type        = string
  default     = ""
}

variable "helm_wait" {
  description = "If true, apply operations will wait for Helm release status."
  type        = bool
  default     = false
}

variable "helm_timeout" {
  description = "The duration time to wait for Helm actions."
  type        = number
  default     = 300
}

variable "cert_manager_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "1.7.1"
}

variable "external_dns_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "6.1.6"
}

variable "kubed_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "0.13.2"
}

variable "linkerd_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "2.11.1"
}

variable "meilisearch_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "0.1.26"
}

variable "metrics_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "3.8.2"
}

variable "ingress_nginx_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "9.1.8"
}

variable "thanos_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "9.0.8"
}
