terraform {
  required_version = "~> 1.1.7"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.8.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.4.1"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.28.1"
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