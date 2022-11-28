project     = "raccoon"
release     = "rapid"
environment = "production"
region      = "us-west2"
zone        = "us-west2-a"

cluster_name       = "primary"
kubernetes_version = "1.24.5-gke.600"
node_disk_size_gb  = 50
node_image_type    = "COS_CONTAINERD"
node_machine_type  = "e2-medium"
node_preemptible   = true
pool_name          = "primary"
