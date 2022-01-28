resource "digitalocean_project" "raccoon" {
  name        = var.project_name
  purpose     = var.project_purpose
  environment = var.project_environment
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${var.project_name}-${random_id.cluster.hex}"
  region = var.cluster_region

  version  = data.digitalocean_kubernetes_versions.prefix.latest_version
  vpc_uuid = digitalocean_vpc.raccoon.id

  auto_upgrade  = true
  surge_upgrade = true

  node_pool {
    name       = "${var.project_name}-${random_id.pool.hex}"
    size       = var.cluster_size
    node_count = var.node_count
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
  }

  maintenance_policy {
    day        = "monday"
    start_time = "00:00"
  }
}

resource "digitalocean_container_registry" "raccoon" {
  name                   = "${var.project_name}-${random_id.registry.hex}"
  subscription_tier_slug = "starter"
}

resource "digitalocean_vpc" "raccoon" {
  name   = "vpc-${var.project_name}-${var.cluster_region}-${random_id.vpc.hex}"
  region = var.cluster_region
}

resource "digitalocean_domain" "raccoon" {
  name = var.domain_name
}
