# raccoon

DigitalOcean Kubernetes Cluster

[![CI](https://github.com/acchiao/raccoon/actions/workflows/ci.yml/badge.svg)](https://github.com/acchiao/raccoon/actions/workflows/ci.yml)

The raccoon, sometimes called the common raccoon to distinguish it from other species, is a medium-sized mammal native to North America.

## Prerequisites

- [Terraform CLI] ^1.1.0
- [DigitalOcean CLI] ^1.69.0
- [Terraform Cloud] Personal Access Token
- [DigitalOcean] Personal Access Token

[Terraform CLI]: https://www.terraform.io/
[DigitalOcean CLI]: https://docs.digitalocean.com/reference/doctl/
[Terraform Cloud]: https://cloud.hashicorp.com/products/terraform/
[DigitalOcean]: https://www.digitalocean.com/

## Usage

Authenticate with Terraform Cloud using `terraform login -init` and source the `DIGITALOCEAN_TOKEN` token.

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

## Kubernetes Add-ons

- [cert-manager]
- [external-dns]
- [kubed]
- [linkerd]

[cert-manager]: https://cert-manager.io/
[external-dns]: https://github.com/kubernetes-sigs/external-dns/
[kubed]: https://appscode.com/products/kubed/
[linkerd]: https://linkerd.io/
