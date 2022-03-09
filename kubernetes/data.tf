data "terraform_remote_state" "raccoon" {
  backend = "remote"

  config = {
    hostname     = "app.terraform.io"
    organization = "acchiao"

    workspaces = {
      name = "production"
    }
  }
}

data "tfe_outputs" "raccoon" {
  organization = "acchiao"
  workspace    = "production"
}

data "kubernetes_all_namespaces" "raccoon" {}
