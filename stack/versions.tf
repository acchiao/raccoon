terraform {
  required_version = "~> 1.14"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.74"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.8"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.73"
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
