terraform {
  required_version = "~> 1.2.3"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.12.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.35.0"
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
