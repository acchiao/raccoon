terraform {
  required_version = "~> 1.10.3"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.37.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.67.0"
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
