terraform {
  required_version = "~> 1.1.4"

  required_providers {
    # https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }

    # https://registry.terraform.io/providers/hashicorp/random/latest/docs
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }

  cloud {
    organization = "acchiao"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["raccoon", "core"]
    }
  }
}
