resource "digitalocean_project" "raccoon" {
  name        = var.do_project_name
  purpose     = var.do_project_purpose
  environment = var.do_project_environment
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${var.do_project_name}-${random_id.cluster.id}"
  region = var.do_cluster_region

  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.prefix.latest_version

  maintenance_policy {
    day        = "monday"
    start_time = "00:00"
  }

  node_pool {
    name       = "${var.do_project_name}-${random_id.pool.id}"
    size       = var.do_cluster_size
    node_count = var.do_node_count
  }
}

resource "digitalocean_container_registry" "raccoon" {
  name                   = "${var.do_project_name}-${random_id.registry.id}"
  subscription_tier_slug = "starter"
}
