terraform {
  required_version = "~> 1.1.5"

  # Providers
  # https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
  # https://registry.terraform.io/providers/hashicorp/random/latest/docs
  # https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
  # https://registry.terraform.io/providers/hashicorp/helm/latest/docs
  # https://registry.terraform.io/providers/hashicorp/tfe/latest/docs

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.7.1"
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
      tags = ["raccoon", "stack"]
    }
  }
}
