terraform {
  required_version = "~> 1.1.7"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.18.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.29.0"
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
