output "project_name" {
  description = "The DigitalOcean project name."
  value       = digitalocean_project.raccoon.name
}

output "registry_name" {
  description = "The DigitalOcean container registry name."
  value       = digitalocean_container_registry.raccoon.name
}

output "vpc_name" {
  description = "The DigitalOcean VPC name."
  value       = digitalocean_vpc.raccoon.name
}

output "region" {
  description = "The DigitalOcean resource region."
  value       = var.region
}

output "cloudflare_zone" {
  description = "The Cloudflare domain."
  value = cloudflare_zone.raccoon.zone
}
