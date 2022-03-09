output "kubernetes_available_namespaces" {
  description = "All available namespaces."
  value       = data.kubernetes_all_namespaces.raccoon.namespaces
}
