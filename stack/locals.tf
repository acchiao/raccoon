locals {
  # Cache remote state outputs to reduce repeated lookups
  core_project_prefix = data.tfe_outputs.raccoon.values.core_project_prefix
  core_region         = data.tfe_outputs.raccoon.values.core_region

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
