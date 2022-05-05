resource "digitalocean_project" "raccoon" {
  name        = "${var.project_name}-${var.environment}"
  environment = var.environment
  purpose     = "Operational / Developer tooling"
}

resource "digitalocean_project_resources" "raccoon" {
  project = digitalocean_project.raccoon.id
  resources = [
    digitalocean_kubernetes_cluster.raccoon.urn,
    digitalocean_domain.acchiao.urn,
  ]
}

resource "digitalocean_domain" "acchiao" {
  name = var.digitalocean_domain
}

resource "digitalocean_record" "github" {
  domain = digitalocean_domain.acchiao.id
  type   = "TXT"
  name   = "_github-pages-challenge-acchiao"
  value  = "bbb69fd4052b905e62f3d32c1b5e1a"
}

resource "digitalocean_vpc" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-${data.terraform_remote_state.raccoon.outputs.core_region}-vpc"
  region = data.terraform_remote_state.raccoon.outputs.core_region
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-cluster"
  region = data.terraform_remote_state.raccoon.outputs.core_region

  version  = data.digitalocean_kubernetes_versions.prefix.latest_version
  vpc_uuid = digitalocean_vpc.raccoon.id

  auto_upgrade  = true
  surge_upgrade = true

  node_pool {
    name = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-pool"
    size = var.cluster_size

    # Uncomment node_count to explicitly reset the number of nodes to this value
    node_count = var.node_count

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
