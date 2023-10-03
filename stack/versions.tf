terraform {
  required_version = "~> 1.3.5"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.30.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.0"
    }

    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.49.1"
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
