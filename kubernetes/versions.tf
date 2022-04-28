terraform {
  required_version = "~> 1.1.7"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.31.0"
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
