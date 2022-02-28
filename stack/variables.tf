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

variable "install_charts" {
  description = "If true, Helm chart releases will be installed."
  type        = bool
  default     = false
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

variable "oauth2_proxy_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "2.0.5"
}

variable "traefik_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "10.14.2"
}

variable "coredns_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "1.16.7"
}

variable "istio_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "1.13.1"
}

variable "calico_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "3.22.0"
}

variable "prometheus_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "33.0.0"
}

variable "fluent_bit_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "0.19.19"
}

variable "haproxy_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "0.3.7"
}

variable "kubernetes_dashboard_version" {
  description = "The version of the Helm chart to install."
  type        = string
  default     = "5.2.0"
}
