# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Terraform-managed Kubernetes infrastructure targeting DigitalOcean and GCP (GKE). All Terraform state is stored in Terraform Cloud (org: `acchiao`) with local execution mode.

## Commands

Each Terraform module (`core`, `stack`, `gke`, `kubernetes`) is an independent working directory. All commands must be run from within the target directory.

```sh
# Initialize (run once per module or after provider changes)
terraform init -upgrade

# Validate and format
terraform validate
terraform fmt -list=true -write=true -recursive -diff

# Plan (use workspace-aware var file)
terraform plan -var-file=env/$(terraform workspace show).tfvars -out=$(terraform workspace show).tfplan

# Apply
terraform apply $(terraform workspace show).tfplan

# Import existing resources
terraform import -var-file=env/$(terraform workspace show).tfvars resource.example resource_id
```

Pre-commit hooks run automatically: `terraform_fmt`, `terraform_validate`, `terraform_providers_lock`, `yamllint`, and standard checks (trailing whitespace, end-of-file-fixer, YAML validation).

CI runs on all pushes/PRs: super-linter, tfsec static analysis, and `terraform validate` + `terraform fmt -check`.

## Architecture

Four Terraform modules with a state dependency chain:

```
core ──► stack ──► kubernetes
              (independent)
gke ──────────────────────────
```

### core/
Global resources shared across all environments (one workspace: `core`). Creates the DigitalOcean project, container registry, and VPC. Its outputs are consumed downstream via `terraform_remote_state`.

**Providers:** digitalocean, tls, random

### stack/
Per-environment infrastructure (one workspace per env: `production`, `staging`). Creates the DOKS cluster, domain records, and VPC. References `core` state for project prefix, region, and project name.

**Providers:** digitalocean, random, tfe

### kubernetes/
Kubernetes add-ons deployed via Helm charts onto the cluster created by `stack`. References `production` workspace state from `stack` for cluster endpoint and kubeconfig. Manages namespaces and Helm releases for: ingress-nginx, external-dns, cert-manager, kubed, linkerd, metrics-server, datadog.

**Providers:** kubernetes, helm, tfe

### gke/
Standalone GCP/GKE cluster (not connected to the DO state chain). Uses `google-beta` provider for Dataplane V2 and advanced features.

**Providers:** google, google-beta, random

## Key Conventions

- **Naming:** `${var.project_name}-${var.environment}-${var.region}-<RESOURCE_TYPE>` (random IDs omitted at this scale)
- **File layout per module:** `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `providers.tf`, `data.tf`, `locals.tf`, `random.tf`, `env/<workspace>.tfvars`
- **Terraform version:** `~> 1.14`
- **Backend:** Terraform Cloud (`app.terraform.io`), workspaces tagged per module (e.g., `["raccoon", "core"]`)
- **Helm charts:** pinned versions in `variables.tf` defaults; `lint = true` on all releases

## Critical Dependency Warning

Changing outputs in `core` can break `stack` and `kubernetes`. Changing outputs in `stack` can break `kubernetes`. After modifying any module's outputs, run `terraform plan` in all downstream modules to verify nothing breaks.

## Environment Variables

```sh
# DigitalOcean modules (core, stack, kubernetes)
export DIGITALOCEAN_TOKEN=...
export CLOUDFLARE_API_TOKEN=...

# GKE module
export TF_VAR_master_authorized_network_cidr=...
export TF_VAR_project_id=...
```

Authenticate with Terraform Cloud first: `terraform login`

## Dependabot

Configured for daily updates (9 AM PT) across all four module directories and GitHub Actions. Uses conventional commit prefix `build` with scope.
