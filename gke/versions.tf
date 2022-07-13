terraform {
  required_version = "~> 1.2.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.28.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.2"
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
