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

data "kubernetes_all_namespaces" "raccoon" {}

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

data "kubernetes_namespace" "kube_system" {
  metadata {
    name = "kube-system"
  }
}

data "kubernetes_namespace" "kube_public" {
  metadata {
    name = "kube-public"
  }
}

data "kubernetes_namespace" "kube_node_lease" {
  metadata {
    name = "kube-node-lease"
  }
}

data "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}
