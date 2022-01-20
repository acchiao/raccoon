resource "digitalocean_project" "raccoon" {
  name        = var.do_project_name
  purpose     = var.do_project_purpose
  environment = var.do_project_environment
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${var.do_project_name}-${random_id.cluster.hex}"
  region = var.do_cluster_region

  version  = data.digitalocean_kubernetes_versions.prefix.latest_version
  vpc_uuid = digitalocean_vpc.raccoon.id

  auto_upgrade  = true
  surge_upgrade = true

  maintenance_policy {
    day        = "monday"
    start_time = "00:00"
  }

  node_pool {
    name       = "${var.do_project_name}-${random_id.pool.hex}"
    size       = var.do_cluster_size
    node_count = var.do_node_count
  }
}

resource "digitalocean_container_registry" "raccoon" {
  name                   = "${var.do_project_name}-${random_id.registry.hex}"
  subscription_tier_slug = "starter"
}

resource "digitalocean_vpc" "raccoon" {
  name   = "vpc-${var.do_project_name}-${var.do_cluster_region}-${random_id.vpc.hex}"
  region = var.do_cluster_region
}
