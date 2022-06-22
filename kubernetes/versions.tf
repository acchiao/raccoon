terraform {
  required_version = "~> 1.2.1"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5.1"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.32.0"
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
