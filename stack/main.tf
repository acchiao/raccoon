resource "digitalocean_project" "raccoon" {
  name        = "${var.project_name}-${var.environment}"
  environment = var.environment
  purpose     = "Operational / Developer tooling"
}

resource "digitalocean_project_resources" "raccoon" {
  project = digitalocean_project.raccoon.id
  resources = [
    digitalocean_kubernetes_cluster.raccoon.urn,
    digitalocean_domain.digitalocean_domain_name.urn,
    digitalocean_loadbalancer.raccoon.urn,
  ]
}

resource "digitalocean_vpc" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-${data.terraform_remote_state.raccoon.outputs.core_region}-${random_id.vpc.hex}"
  region = data.terraform_remote_state.raccoon.outputs.core_region
}

resource "digitalocean_kubernetes_cluster" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-${random_id.cluster.hex}"
  region = data.terraform_remote_state.raccoon.outputs.core_region

  version  = data.digitalocean_kubernetes_versions.prefix.latest_version
  vpc_uuid = digitalocean_vpc.raccoon.id

  auto_upgrade  = true
  surge_upgrade = true

  node_pool {
    name = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-${random_id.pool.hex}"
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

resource "digitalocean_domain" "digitalocean_domain_name" {
  name = var.digitalocean_domain_name
}

resource "digitalocean_loadbalancer" "raccoon" {
  name   = "${data.terraform_remote_state.raccoon.outputs.core_project_prefix}-${var.environment}-${data.terraform_remote_state.raccoon.outputs.core_region}-${random_id.loadbalancer.hex}"
  region = data.terraform_remote_state.raccoon.outputs.core_region

  vpc_uuid    = digitalocean_vpc.raccoon.id
  droplet_tag = "terraform:default-node-pool"

  size_unit = 1

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http" # #tfsec:ignore:digitalocean-compute-enforce-https

    target_port     = 80
    target_protocol = "http"
  }
}
