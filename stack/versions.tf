terraform {
  required_version = "~> 1.1.6"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
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
