data "tfe_outputs" "raccoon" {
  organization = "acchiao"
  workspace    = "core"
}

data "digitalocean_project" "raccoon" {
  name = data.tfe_outputs.raccoon.values.core_project_name
}

data "digitalocean_kubernetes_versions" "latest" {
  version_prefix = "1.31."
}
