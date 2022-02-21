resource "digitalocean_project" "raccoon" {
  name        = "${var.project_name}-${var.environment}"
  environment = var.project_environment
}

resource "digitalocean_project_resources" "raccoon" {
  project   = digitalocean_project.raccoon.id
  resources = []
}

resource "digitalocean_container_registry" "raccoon" {
  name                   = "${var.project_name}-${var.environment}-registry-${random_id.vpc.hex}"
  subscription_tier_slug = "basic"
}

# resource "digitalocean_vpc" "raccoon" {
#   name   = "${var.project_name}-${var.environment}-${var.region}-vpc-${random_id.vpc.hex}"
#   region = var.region
# }
