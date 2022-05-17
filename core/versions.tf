terraform {
  required_version = "~> 1.1.7"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.19.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
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
