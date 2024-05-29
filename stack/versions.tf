terraform {
  required_version = "~> 1.3.5"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.39.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.55.0"
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
