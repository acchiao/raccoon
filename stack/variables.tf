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
