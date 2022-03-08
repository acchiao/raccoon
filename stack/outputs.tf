output "vpc_name" {
  description = "The DigitalOcean VPC name."
  value       = digitalocean_vpc.raccoon.name
}

output "kubernetes_cluster_name" {
  description = "The DigitalOcean Kubernetes cluster name."
  value       = digitalocean_kubernetes_cluster.raccoon.name
}

output "kubernetes_node_pool_name" {
  description = "The DigitalOcean Kubernetes cluster version."
  value       = digitalocean_kubernetes_cluster.raccoon.node_pool[0].name
}

output "kubernetes_cluster_version" {
  description = "The DigitalOcean Kubernetes cluster version."
  value       = digitalocean_kubernetes_cluster.raccoon.version
}

output "kubernetes_node_count" {
  description = "The current node count."
  value       = digitalocean_kubernetes_cluster.raccoon.node_pool[0].actual_node_count
}

output "kubernetes_available_namespaces" {
  description = "All available namespaces."
  value       = data.kubernetes_all_namespaces.raccoon.namespaces
}

output "kubernetes_endpoint" {
  description = "The DigitalOcean Kubernetes cluster endpoint."
  value       = digitalocean_kubernetes_cluster.raccoon.endpoint
}

output "kubernetes_kube_config" {
  description = "The DigitalOcean Kubernetes cluster kubeconfig."
  value       = digitalocean_kubernetes_cluster.raccoon.kube_config
  sensitive   = true
}
