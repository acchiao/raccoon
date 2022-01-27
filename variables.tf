variable "project_name" {
  description = "The DigitalOcean project name."
  type        = string
  default     = ""
}

variable "project_purpose" {
  description = "The DigitalOcean project purpose."
  type        = string
  default     = "Web Application"
}

variable "project_environment" {
  description = "The DigitalOcean project environment."
  type        = string
  default     = ""
}

variable "cluster_region" {
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
