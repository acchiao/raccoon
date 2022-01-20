variable "do_project_name" {
  description = "The DigitalOcean project name."
  type        = string
  default     = ""
}

variable "do_project_purpose" {
  description = "The DigitalOcean project purpose."
  type        = string
  default     = "Web Application"
}

variable "do_project_environment" {
  description = "The DigitalOcean project environment."
  type        = string
  default     = ""
}

variable "do_cluster_version" {
  description = "See `doctl kubernetes options versions`."
  type        = string
  default     = "1.21.5-do.0"
}

variable "do_cluster_region" {
  description = "See `doctl kubernetes options regions`."
  type        = string
  default     = "nyc1"
}

variable "do_cluster_size" {
  description = "See `doctl kubernetes options sizes`."
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "do_node_count" {
  description = "The number of Droplet instances in the node pool."
  type        = number
  default     = 1
}
