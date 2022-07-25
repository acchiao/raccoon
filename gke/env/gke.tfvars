project     = "raccoon"
release     = "stable"
environment = "production"
region      = "us-central1"
zone        = "us-central1-a"

cluster_name       = "primary"
kubernetes_version = "1.23.8-gke.400"
node_disk_size_gb  = 50
node_image_type    = "COS_CONTAINERD"
node_machine_type  = "e2-medium"
node_preemptible   = true
pool_name          = "primary"
