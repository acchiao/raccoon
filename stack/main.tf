resource "digitalocean_project" "raccoon" {
  name        = "${var.project_name}-${var.environment}"
  environment = var.environment
}

resource "digitalocean_project_resources" "raccoon" {
  project = digitalocean_project.raccoon.id
  resources = [
    digitalocean_kubernetes_cluster.raccoon.urn
  ]
}

resource "digitalocean_vpc" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.project_name}-${var.environment}-${data.terraform_remote_state.raccoon.outputs.region}-${random_id.vpc.hex}"
  region = data.terraform_remote_state.raccoon.outputs.region
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.project_name}-${random_id.cluster.hex}"
  region = data.terraform_remote_state.raccoon.outputs.region

  version  = data.digitalocean_kubernetes_versions.prefix.latest_version
  vpc_uuid = digitalocean_vpc.raccoon.id

  auto_upgrade  = true
  surge_upgrade = true

  node_pool {
    name = "${data.terraform_remote_state.raccoon.outputs.project_name}-${random_id.pool.hex}"
    size = var.cluster_size

    # Uncomment node_count to explicitly reset the number of nodes to this value
    # node_count = var.node_count

    auto_scale = var.auto_scale
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes

    tags   = local.common_tags
    labels = local.node_labels
  }

  maintenance_policy {
    day        = "monday"
    start_time = "00:00"
  }

  tags = local.common_tags
}
