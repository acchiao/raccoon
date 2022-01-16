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
