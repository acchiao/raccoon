locals {
  # Cache Kubernetes cluster connection details to avoid duplication
  k8s_host  = data.tfe_outputs.raccoon.values.kubernetes_endpoint
  k8s_token = data.tfe_outputs.raccoon.values.kubernetes_kube_config[0].token
  k8s_ca_certificate = base64decode(
    data.tfe_outputs.raccoon.values.kubernetes_kube_config[0].cluster_ca_certificate
  )

  # Standardized naming prefix
  prefix = "${var.project_name}-${var.environment}-${var.region}"

  # DigitalOcean resource tags are a list of tag names (no key-value assignments)
  common_tags = [
    var.project_name,
    var.environment,
    var.region,
  ]

  node_labels = {
    "project"     = var.project_name,
    "environment" = var.environment,
    "release"     = var.release,
    "region"      = var.region,
  }
}
