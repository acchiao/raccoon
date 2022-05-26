terraform {
  required_version = "~> 1.2.1"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.20.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.2.0"
    }

    # cloudflare = {
    #   source  = "cloudflare/cloudflare"
    #   version = "~> 3.13.0"
    # }

    # okta = {
    #   source  = "okta/okta"
    #   version = "~> 3.25.0"
    # }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.4.0"
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
