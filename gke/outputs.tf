output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_version" {
  value = google_container_cluster.primary.master_version
}

output "node_pool_name" {
  value = google_container_node_pool.primary.name
}

output "gcloud_auth" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name}"
}

output "stable_channel_version" {
  value = data.google_container_engine_versions.current.release_channel_default_version["STABLE"]
}

output "regular_channel_version" {
  value = data.google_container_engine_versions.current.release_channel_default_version["REGULAR"]
}

output "rapid_channel_version" {
  value = data.google_container_engine_versions.current.release_channel_default_version["RAPID"]
}
