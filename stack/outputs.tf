output "cluster_name" {
  description = "The DigitalOcean Kubernetes cluster name."
  value       = digitalocean_kubernetes_cluster.raccoon.name
}

output "vpc_name" {
  description = "The DigitalOcean VPC name."
  value       = digitalocean_vpc.raccoon.name
}

output "loadbalancer_name" {
  description = "The DigitalOcean loadbalancer name."
  value       = digitalocean_loadbalancer.raccoon.name
}

output "loadbalancer_id" {
  description = "The DigitalOcean loadbalancer ID."
  value       = digitalocean_loadbalancer.raccoon.id
}

output "cluster_version" {
  description = "The DigitalOcean Kubernetes cluster version."
  value       = digitalocean_kubernetes_cluster.raccoon.version
}

output "node_count" {
  description = "The current node count."
  value       = digitalocean_kubernetes_cluster.raccoon.node_pool[0].actual_node_count
}
