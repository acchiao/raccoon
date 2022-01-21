output "project_name" {
  description = "The DigitalOcean Kubernetes cluster name."
  value       = digitalocean_project.raccoon.name
}

output "cluster_name" {
  description = "The DigitalOcean Kubernetes cluster name."
  value       = digitalocean_kubernetes_cluster.raccoon.name
}

output "cluster_version" {
  description = "The DigitalOcean Kubernetes cluster version."
  value       = digitalocean_kubernetes_cluster.raccoon.version
}

output "node_count" {
  description = "The current node count."
  value = digitalocean_kubernetes_cluster.raccoon.node_pool[0].actual_node_count
}
