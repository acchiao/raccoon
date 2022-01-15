terraform {
  required_version = "~> 1.1.3"

  required_providers {
    # https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.17.0"
    }

    # https://registry.terraform.io/providers/hashicorp/random/latest/docs
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "acchiao"

    workspaces {
      prefix = "raccoon-"
    }
  }
}
