terraform {
  required_version = "~> 1.3.5"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.53.0"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "acchiao"

    workspaces {
      tags = ["raccoon", "stack", "kubernetes"]
    }
  }
}
