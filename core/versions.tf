terraform {
  required_version = "~> 1.3.5"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.45.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
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
      version = "~> 4.0.0"
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
