# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

resource "google_service_account" "default" {
  account_id   = "${data.google_project.project.name}-service-account"
  display_name = "${data.google_project.project.name} - Service Account"
  description  = "${data.google_project.project.name} - Service Account"
}

resource "google_container_cluster" "primary" {
  provider = google-beta

  name     = "${var.environment}-${var.cluster_name}-${random_id.cluster.hex}"
  location = var.zone

  initial_node_count       = 1
  remove_default_node_pool = true
  enable_shielded_nodes    = true
  min_master_version       = var.kubernetes_version

  # GKE Dataplane V2
  datapath_provider = "ADVANCED_DATAPATH"
  networking_mode   = "VPC_NATIVE"

  ip_allocation_policy {}

  cluster_autoscaling {
    enabled = false
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS",
    ]
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
    ]
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "authorized-networks"
      cidr_block   = var.master_authorized_network_cidr
    }
  }

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "primary" {
  name     = "${var.environment}-${var.pool_name}-${random_id.cluster.hex}"
  location = var.zone

  cluster = google_container_cluster.primary.id

  node_count = 1
  version    = var.kubernetes_version

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    image_type   = "COS_CONTAINERD"
    disk_size_gb = 50

    metadata = {
      disable-legacy-endpoints = "true"
    }

    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
