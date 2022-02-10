terraform {
  required_version = "~> 1.1.5"

  required_providers {
    # See https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.1"
    }

    # See https://registry.terraform.io/providers/hashicorp/random/latest/docs
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    # See https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.8.0"
    }

    # See https://registry.terraform.io/providers/okta/okta/latest/docs
    okta = {
      source  = "okta/okta"
      version = "~> 3.20"
    }

    # See https://registry.terraform.io/providers/hashicorp/tls/latest/docs
    tls = {
      source  = "hashicorp/tls"
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
