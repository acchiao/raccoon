output "core_project_name" {
  description = "The DigitalOcean project name."
  value       = digitalocean_project.raccoon.name
}

output "core_project_prefix" {
  description = "The DigitalOcean project prefix."
  value       = var.project_name
}

# output "core_registry_name" {
#   description = "The DigitalOcean container registry name."
#   value       = digitalocean_container_registry.raccoon.name
# }

# output "core_registry_endpoint" {
#   description = "The DigitalOcean container registry endpoint."
#   value       = digitalocean_container_registry.raccoon.endpoint
# }

output "core_region" {
  description = "The DigitalOcean resource region."
  value       = var.region
}

output "cloudflare_zone" {
  description = "The Cloudflare domain."
  value       = cloudflare_zone.raccoon.zone
}

# output "cloudflare_zone_id" {
#   description = "The Cloudflare DNS zone ID."
#   value       = cloudflare_zone.raccoon.id
# }
