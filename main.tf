resource "digitalocean_project" "raccoon" {
  name        = var.do_project_name
  environment = var.do_project_environment
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name    = "${var.do_project_name}-${random_id.cluster.dec}"
  region  = var.do_cluster_region
  version = var.do_cluster_version

  node_pool {
    name       = "${var.do_project_name}-${random_id.pool.dec}"
    size       = var.do_cluster_size
    node_count = var.do_node_count
  }
}
