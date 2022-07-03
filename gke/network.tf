# resource "google_compute_network" "vpc" {
#   name = "${var.cluster_name}-kube-vpc"
#   auto_create_subnetworks = "false"
# }

# resource "google_compute_subnetwork" "subnet" {
#   name                     = "${var.cluster_name}-kube-subnet"
#   ip_cidr_range            = var.primary_ip_cidr
#   network                  = google_compute_network.k8s_vpc.id
#   private_ip_google_access = "true"
#   region                   = var.region
# }
