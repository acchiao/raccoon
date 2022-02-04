variable "environment" {
  description = "The project environment."
  type        = string
}

variable "project_name" {
  description = "The DigitalOcean project name."
  type        = string
}

variable "project_environment" {
  description = "The DigitalOcean project environment. The possible values are: `Development`, `Staging`, `Production`."
  type        = string
}

variable "region" {
  description = "See `doctl kubernetes options regions`."
  type        = string
  default     = "nyc1"
}

variable "domain_name" {
  description = "The name of the DigitalOcean domain resource."
  type        = string
  default     = ""
}
