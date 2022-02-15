resource "digitalocean_project" "raccoon" {
  name        = "${var.project_name}-${var.environment}"
  environment = var.project_environment
}

resource "digitalocean_project_resources" "raccoon" {
  project = digitalocean_project.raccoon.id
  resources = [
    digitalocean_domain.site.urn,
    digitalocean_domain.raccoon.urn,
  ]
}

resource "digitalocean_container_registry" "raccoon" {
  name                   = "${var.project_name}-${var.environment}-${random_id.vpc.hex}"
  subscription_tier_slug = "starter"
}

resource "digitalocean_vpc" "raccoon" {
  name   = "${var.project_name}-${var.environment}-${var.region}-${random_id.vpc.hex}"
  region = var.region
}

resource "digitalocean_domain" "raccoon" {
  name = var.raccoon_domain_name
}

resource "digitalocean_domain" "site" {
  name = var.domain_name
}
