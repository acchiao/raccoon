terraform {
  required_version = "~> 1.10.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.38.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.1"
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
