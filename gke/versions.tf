terraform {
  required_version = "~> 1.14"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.18.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.8"
    }
  }

  cloud {
    hostname     = "app.terraform.io"
    organization = "acchiao"

    workspaces {
      tags = ["google", "gke"]
    }
  }
}
