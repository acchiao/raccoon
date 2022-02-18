data "terraform_remote_state" "raccoon" {
  backend = "remote"

  config = {
    hostname     = "app.terraform.io"
    organization = "acchiao"

    workspaces = {
      name = "core"
    }
  }
}

# TODO: Replace terraform_remote_state data source with tfe_outputs
data "tfe_outputs" "raccoon" {
  organization = "acchiao"
  workspace    = "core"
}

data "digitalocean_project" "raccoon" {
  name = data.terraform_remote_state.raccoon.outputs.core_project_name
}

data "digitalocean_kubernetes_versions" "prefix" {
  version_prefix = "1.21."
}

data "kubernetes_all_namespaces" "raccoon" {}
