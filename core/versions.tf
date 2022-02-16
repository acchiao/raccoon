terraform {
  required_version = "~> 1.1.5"

  # Providers
  # https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
  # https://registry.terraform.io/providers/hashicorp/random/latest/docs
  # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
  # https://registry.terraform.io/providers/okta/okta/latest/docs
  # https://registry.terraform.io/providers/hashicorp/tls/latest/docs

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

    okta = {
      source  = "okta/okta"
      version = "~> 3.21.0"
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
