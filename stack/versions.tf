terraform {
  required_version = "~> 1.10.3"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.72.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.8.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.73.0"
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
