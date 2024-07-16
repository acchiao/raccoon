terraform {
  required_version = "~> 1.3.5"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.14.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.57.0"
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
