locals {
  # Standardized naming prefix
  prefix = "${var.project_name}-${var.environment}-${var.region}"

  # DigitalOcean resource tags are a list of tag names (no key-value assignments)
  common_tags = [
    var.project_name,
    var.environment,
  ]

  node_labels = {
    "project"     = var.project_name
    "environment" = var.environment
  }
}
