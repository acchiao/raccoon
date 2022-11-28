# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

resource "google_service_account" "default" {
  account_id   = "${data.google_project.project.name}-service-account"
  display_name = "${data.google_project.project.name} - Service Account"
  description  = "${data.google_project.project.name} - Service Account"
}

# tfsec:ignore:google-gke-enable-private-cluster tfsec:ignore:google-gke-enforce-pod-security-policy
resource "google_container_cluster" "primary" {
  provider = google-beta

  name     = "${var.cluster_name}-${random_id.cluster.hex}"
  location = var.zone

  initial_node_count       = 1
  remove_default_node_pool = true
  enable_shielded_nodes    = true

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

  # tfsec:ignore:google-gke-enable-network-policy
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

  resource_labels = {
    "project"     = var.project,
    "project_id"  = var.project_id,
    "environment" = var.environment,
    "release"     = var.release,
    "region"      = var.region,
    "zone"        = var.zone,
  }
}

resource "google_container_node_pool" "primary" {
  name     = "${var.environment}-${var.pool_name}-${random_id.cluster.hex}"
  cluster  = google_container_cluster.primary.id
  location = var.zone

  node_count = var.node_count
  version    = data.google_container_engine_versions.current.release_channel_default_version["RAPID"]

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  # tfsec:ignore:google-gke-enforce-pod-security-policy tfsec:ignore:google-gke-metadata-endpoints-disabled
  node_config {
    service_account = google_service_account.default.email

    preemptible  = var.node_preemptible
    machine_type = var.node_machine_type
    image_type   = var.node_image_type
    disk_size_gb = var.node_disk_size_gb

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    metadata = {
      disable-legacy-endpoints = true
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  depends_on = [
    google_container_cluster.primary
  ]
}
