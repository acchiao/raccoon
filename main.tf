resource "digitalocean_project" "raccoon" {
  name        = var.do_project_name
  environment = var.do_project_environment
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${var.do_project_name}-${random_id.cluster.dec}"
  region = var.do_cluster_region

  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.prefix.latest_version

  maintenance_policy {
    day        = "monday"
    start_time = "00:00"
  }

  node_pool {
    name       = "${var.do_project_name}-${random_id.pool.dec}"
    size       = var.do_cluster_size
    node_count = var.do_node_count
  }
}
