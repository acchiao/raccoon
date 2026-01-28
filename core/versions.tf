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

    # cloudflare = {
    #   source  = "cloudflare/cloudflare"
    #   version = "~> 3.13"
    # }

    # okta = {
    #   source  = "okta/okta"
    #   version = "~> 3.25"
    # }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.1"
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
