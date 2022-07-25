output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_version" {
  value = google_container_cluster.primary.master_version
}
