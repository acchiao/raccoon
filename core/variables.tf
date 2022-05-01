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
  default     = "Production"
}

variable "region" {
  description = "See `doctl kubernetes options regions`."
  type        = string
  default     = "nyc1"
}

variable "container_registry_region" {
  description = "See `doctl kubernetes options regions`."
  type        = string
  default     = "nyc3"
}

# variable "cloudflare_zone_name" {
#   description = "The name of the Cloudflare zone."
#   type        = string
#   default     = ""
# }

# variable "okta_subdomain" {
#   description = "The name of the Okta subdomain."
#   type        = string
#   default     = ""
# }
