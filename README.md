# raccoon

[![CI](https://github.com/acchiao/raccoon/actions/workflows/ci.yml/badge.svg)](https://github.com/acchiao/raccoon/actions/workflows/ci.yml)

Terraform-Managed DigitalOcean Kubernetes Cluster.

The raccoon, sometimes called the common raccoon to distinguish it from other species, is a medium-sized mammal native to North America.

## Prerequisites

- [Terraform CLI] ^1.1.0
- [DigitalOcean CLI] ^1.69.0
- [Terraform Cloud] Personal Access Token
- [DigitalOcean] Personal Access Token
- [Cloudflare] Personal Access Token

[terraform cli]: https://www.terraform.io/
[digitalocean cli]: https://docs.digitalocean.com/reference/doctl/
[terraform cloud]: https://cloud.hashicorp.com/products/terraform/
[digitalocean]: https://www.digitalocean.com/
[cloudflare]: https://www.cloudflare.com/

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
RPROMPT='$(terraform workspace show)'
RPROMPT='$(kubectl config current-context)'
RPROMPT='$(kubectl config view --minify --output "jsonpath={..namespace}")'

terraform init -upgrade
terraform validate
terraform fmt -list=true -write=true -recursive -diff
terraform refresh -var-file=env/$(terraform workspace show).tfvars
terraform plan -var-file=env/$(terraform workspace show).tfvars -out=$(terraform workspace show).tfplan
terraform import -var-file=env/$(tf workspace show).tfvars resource.example resource
terraform output
terraform output -json

doctl registry login
doctl kubernetes cluster registry add <cluster-id|cluster-name>
doctl kubernetes cluster kubeconfig save <cluster-id|cluster-name>

find . -type f -name "*.tfplan" -print -delete
find . -type d -name ".terraform" -print -prune -exec rm -rf {} +
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

At the highest level, this project is split into two logical groupings. For the core and stack folders, each represents a Terraform working directory. Resources that reside in the core directory are common entities that are unique **_per project_** (e.g., a single container registry used across the `test`/`dev`/`stage`/`prod` environments). From an environment perspective, these might be considered global resources or entities, and don't easily fit into the traditional classifications. Resources that reside in the stack directory are entities that are unique **_per environment_** (e.g., creating individual VPCs to isolate execution environments). Whereas the core directory has a one-to-one mapping to a single workspace, the stack directory has a one-to-many relationship; each workspace maps to an environment. Determining where a resource belongs is highly subjective and will be governed by cost, scale, project requirements, and resource limitations.

As the `core` workspace has resources that will be referenced in each environment, its state backend is used as a `terraform_remote_state` data source.

[digitalocean dns]: https://docs.digitalocean.com/products/networking/dns/

### Core

### Stack

The Linkerd Helm chart doesn't generate the trust anchor certificate and the issuer certificate/key required for mTLS connections. Linkerd requires ECDSA P-256 certificates which can be created using `openssl` or `step`. See [Installing Linkerd with Helm].

[installing linkerd with helm]: https://linkerd.io/2.11/tasks/generate-certificates/

```sh
# Generate the root certificate and private key
step certificate create root.linkerd.cluster.local ca.crt ca.key \
  --profile root-ca \
  --no-password \
  --insecure

# Generate the intermediate certificate and key pair to sign the Linkerd proxies’ CSR
step certificate create identity.linkerd.cluster.local issuer.crt issuer.key \
  --profile intermediate-ca \
  --not-after 8760h \
  --no-password \
  --insecure \
  --ca ca.crt \
  --ca-key ca.key
```

### Helm

The Helm releases are defined within the `.tf` files prepended with `helm-`. The creation of the namespace is left up to the `kubernetes_namespace` block rather than relying on the `create_namespace` parameter within `helm_release`.

## Chicken or the Egg/Turtles All the Way Down

All Terraform states are stored in Terraform Cloud for state management. The execution mode for each workspace has been set to `Local` and all plans, applies, and state operations are performed locally.

## Cost

The total cost for this project as of February 2022 is around $20, depending on the number of nodes and if the load balancer exists. Other costs such as the domain name registrations aren't included. The cost breakdown is below.

| Resource                                          | Cost per Resource  | Cost per Month |
| ------------------------------------------------- | ------------------ | -------------- |
| DigitalOcean Kubernetes Control Plane (non-HA)    | Free               | $0             |
| DigitalOcean Kubernetes Worker Node (autoscaling) | $10 per node       | $10-$20        |
| DigitalOcean Container Registry (free-basic)      | $0-$5 per registry | $0-$5          |
| DigitalOcean Load Balancer                        | $10.00 per node    | $10            |

See [DigitalOcean pricing].

[digitalocean pricing]: https://www.digitalocean.com/pricing/

## Kubernetes Add-ons

- [cert-manager]
- [external-dns]
- [kubed]
- [linkerd]

[cert-manager]: https://cert-manager.io/
[external-dns]: https://github.com/kubernetes-sigs/external-dns/
[kubed]: https://appscode.com/products/kubed/
[linkerd]: https://linkerd.io/

## DigitalOcean

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%203.svg)](https://www.digitalocean.com/?refcode=3d0d2831fcb4&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)
