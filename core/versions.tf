terraform {
  required_version = "~> 1.1.5"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.9.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "acchiao"

    workspaces {
      tags = ["raccoon", "core"]
    }
  }
}
