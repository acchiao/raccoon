terraform {
  required_version = "~> 1.10.3"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.57.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.1"
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
      version = "~> 4.1.0"
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
