terraform {
  required_version = "~> 1.2.3"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.22.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.36.0"
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
