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

data "digitalocean_project" "raccoon" {
  name = data.terraform_remote_state.raccoon.outputs.core_project_name
}

data "digitalocean_kubernetes_versions" "prefix" {
  version_prefix = "1.21."
}
