terraform {
  required_version = "~> 1.3.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.14.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
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
