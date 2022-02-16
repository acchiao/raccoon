# raccoon

DigitalOcean Kubernetes Cluster

[![CI](https://github.com/acchiao/raccoon/actions/workflows/ci.yml/badge.svg)](https://github.com/acchiao/raccoon/actions/workflows/ci.yml)

The raccoon, sometimes called the common raccoon to distinguish it from other species, is a medium-sized mammal native to North America.

## Prerequisites

- [Terraform CLI] ^1.1.0
- [DigitalOcean CLI] ^1.69.0
- [Terraform Cloud] Personal Access Token
- [DigitalOcean] Personal Access Token
- [Cloudflare] Personal Access Token

[Terraform CLI]: https://www.terraform.io/
[DigitalOcean CLI]: https://docs.digitalocean.com/reference/doctl/
[Terraform Cloud]: https://cloud.hashicorp.com/products/terraform/
[DigitalOcean]: https://www.digitalocean.com/
[Cloudflare]: https://www.cloudflare.com/

## Usage

Authenticate with Terraform Cloud using `terraform login -init`. Source the following environment variables.

- `DIGITALOCEAN_TOKEN`
- `CLOUDFLARE_API_TOKEN`
- `CLOUDFLARE_API_USER_SERVICE_KEY`
- `OKTA_ORG_NAME`
- `OKTA_BASE_URL`
- `OKTA_API_TOKEN`

```sh
alias tf="terraform"
RPROMPT+="$(terraform workspace show)"

terraform init -upgrade
terraform validate
terraform fmt -list=true -write=true -recursive -diff
terraform refresh -var-file=env/$(terraform workspace show).tfvars
terraform plan -var-file=env/$(terraform workspace show).tfvars -out=$(terraform workspace show).tfplan
terraform output

find . -type f -name "*.tfplan" -print -delete
find . -type d -name ".terraform" -print -prune -exec rm -rf {} +;
```

## Bird's Eye View

```console
raccoon
├── core
│   ├── env
│   │   └── core.tfvars
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
└── stack
    ├── env
    │   ├── development.tfvars
    │   ├── staging.tfvars
    │   └── production.tfvars
    ├── main.tf
    ├── outputs.tf
    └── variables.tf
```

At the highest level, this project is split into two logical groupings. For the core and stack folders, each represents a Terraform working directory. Resources that reside in the core directory are common entities that are unique ***per project*** (e.g., a single container registry used across the `test`/`dev`/`stage`/`prod` environments). From an environment perspective, these might be considered global resources or entities, and don't easily fit into the traditional classifications. Resources that reside in the stack directory are entities that are unique ***per environment*** (e.g., creating individual VPCs to isolate execution environments). Whereas the core directory has a one-to-one mapping to a single workspace, the stack directory has a one-to-many relationship; each workspace maps to an environment. Determining where a resource belongs is highly subjective and will be governed by cost, scale, project requirements, and resource limitations.

## Chicken or the Egg

All Terraform states are stored in Terraform Cloud for state management. The execution mode for each workspace has been set to `Local` and all plans, applies, or state operations are performed locally.

## Kubernetes Add-ons

- [cert-manager]
- [external-dns]
- [kubed]
- [linkerd]

[cert-manager]: https://cert-manager.io/
[external-dns]: https://github.com/kubernetes-sigs/external-dns/
[kubed]: https://appscode.com/products/kubed/
[linkerd]: https://linkerd.io/
