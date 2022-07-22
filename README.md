# raccoon

[![CI](https://github.com/acchiao/raccoon/actions/workflows/ci.yml/badge.svg)](https://github.com/acchiao/raccoon/actions/workflows/ci.yml)

Terraform-Managed DigitalOcean Kubernetes Cluster.

The raccoon, sometimes called the common raccoon to distinguish it from other species, is a medium-sized mammal native to North America.

## Prerequisites

- [Terraform CLI] ^1.1.0
- [DigitalOcean CLI] ^1.73.0
- [Google Cloud SDK ^393.0.0]
- [Terraform Cloud] Personal Access Token
- [DigitalOcean] Personal Access Token
- [Cloudflare] Personal Access Token

[terraform cli]: https://www.terraform.io/
[digitalocean cli]: https://docs.digitalocean.com/reference/doctl/
[terraform cloud]: https://cloud.hashicorp.com/products/terraform/
[digitalocean]: https://www.digitalocean.com/
[cloudflare]: https://www.cloudflare.com/
[google cloud sdk]: https://cloud.google.com/sdk/

## Usage

Authenticate with Terraform Cloud using `terraform login -init`. Source the following environment variables.

- `DIGITALOCEAN_TOKEN`
- `CLOUDFLARE_API_TOKEN`

## Bird's Eye View

```console
raccoon
├── core
│   ├── env
│   │   └── core.tfvars
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── stack
│   ├── env
│   │   ├── development.tfvars
│   │   ├── staging.tfvars
│   │   └── production.tfvars
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── kubernetes
│   ├── certificates
│   │   ├── ca.crt
│   │   ├── ca.key
│   │   ├── issuer.crt
│   │   └── issuer.key
│   ├── env
│   │   └── kubernetes.tfvars
│   ├── locals.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── values
│   │   ├── external-dns-values.yaml
│   │   └── nginx-ingress-values.yaml
│   ├── variables.tf
│   └── versions.tf
```

At the highest level, this project is split into two logical groupings. For the core and stack folders, each represents a Terraform working directory. Resources that reside in the core directory are common entities that are unique **_per project_** (e.g., a single container registry used across the `test`/`dev`/`stage`/`prod` environments). From an environment perspective, these might be considered global resources or entities, and don't easily fit into the traditional classifications. Resources that reside in the stack directory are entities that are unique **_per environment_** (e.g., creating individual VPCs to isolate execution environments). Whereas the core directory has a one-to-one mapping to a single workspace, the stack directory has a one-to-many relationship; each workspace maps to an environment. Determining where a resource belongs is highly subjective and will be governed by cost, scale, project requirements, and resource limitations.

As the `core` workspace has resources that will be referenced in each environment, its state backend is used as a `terraform_remote_state` data source. All Terraform states are stored in Terraform Cloud for state management. The execution mode for each workspace has been set to `Local` and all plans, applies, and state operations are performed locally.

The [CI workflows] provide static analysis, linting and validation, and [drift detection]. Tools like [tfsec], [snyk], and [checkov], help identify security issues, while dynamic tools such as Amazon Inspector, AWS Config, and AWS Security Hub, extend the coverage by evaluating any existing environments and services. Drift detection detects and assists in reconciling real-world drift.

[ci workflows]: ./github/workflows/ci.yml
[drift detection]: https://www.hashicorp.com/blog/detecting-and-managing-drift-with-terraform/
[tfsec]: https://aquasecurity.github.io/tfsec/v1.4.2/
[snyk]: https://snyk.io/product/infrastructure-as-code-security/
[checkov]: https://www.checkov.io/

### Authentication

Okta is the current identity provider for this project and has been configured with a custom domain. Information about the authorization server can be gleaned from the following URLs.

- [https://sso.raccoon.team/oauth2/default/.well-known/oauth-authorization-server](https://sso.raccoon.team/oauth2/default/.well-known/oauth-authorization-server)
- [https://arthurchiao.okta.com/oauth2/default/.well-known/oauth-authorization-server](https://arthurchiao.okta.com/oauth2/default/.well-known/oauth-authorization-server)

### Resource Naming

For a project this size, the resource names omit the randomly generated ID typically included to ensure uniqueness. None of the resources use the `count` meta-argument either, so the count/number is also omitted. The typical naming convention is as follows: `${var.project_name}-${var.environment}-${var.region}-<RESOURCE_TYPE>`

### Core Module

When updating the outputs of the `core` module, ensure that the changes don't affect any resources downstream. The `stack` module references the outputs with a `terraform_remote_state` data source, so a plan operation should be run in the `stack` workspace to verify references to the old attributes haven't changed. The same should be done in the `kubernetes` folder.

```console
# Example of breaking changes when renaming or removing outputs used downstream
│ Error: Unsupported attribute
│
│   on data.tf line 21, in data "digitalocean_project" "raccoon":
│   21:   name = data.terraform_remote_state.raccoon.outputs.core_project_name
│     ├────────────────
│     │ data.terraform_remote_state.raccoon.outputs is object with 7 attributes
│
│ This object does not have an attribute named "core_project_name".
```

### Stack Module

The `stack` folder/module contains infrastructure-related resources. The environment-specific items within Kubernetes have been moved to the `kubernetes` directory/module to decouple infrastructure resources and Kubernetes-related items.

The Linkerd Helm chart doesn't generate the trust anchor certificate and the issuer certificate/key required for mTLS connections. Linkerd requires ECDSA P-256 certificates which can be created using `openssl` or `step`. See [Installing Linkerd with Helm].

[installing linkerd with helm]: https://linkerd.io/2.11/tasks/generate-certificates/

```sh
# Generate the root certificate and private key
step certificate create root.linkerd.cluster.local certificates/ca.crt certificates/ca.key \
  --profile root-ca \
  --no-password \
  --insecure

# Generate the intermediate certificate and key pair to sign the Linkerd proxies’ CSR
step certificate create identity.linkerd.cluster.local certificates/issuer.crt certificates/issuer.key \
  --profile intermediate-ca \
  --not-after 8760h \
  --no-password \
  --insecure \
  --ca certificates/ca.crt \
  --ca-key certificates/ca.key
```

## Kubernetes Add-ons

- [cert-manager]
- [external-dns]
- [kubed]
- [linkerd]
- [meilisearch]
- [metrics]
- [nginx-ingress]
- [oauth2-proxy]
- [thanos]

[cert-manager]: https://cert-manager.io/
[external-dns]: https://github.com/kubernetes-sigs/external-dns/
[kubed]: https://appscode.com/products/kubed/
[linkerd]: https://linkerd.io/
[meilisearch]: https://www.meilisearch.com/
[metrics]: https://github.com/kubernetes-sigs/metrics-server
[nginx-ingress]: https://kubernetes.github.io/ingress-nginx/
[oauth2-proxy]: https://oauth2-proxy.github.io/oauth2-proxy/
[thanos]: https://thanos.io/

## Datadog Upkeep

```sh
helm upgrade datadog \
    --install \
    --namespace datadog \
    --values values/datadog.yml \
    --set datadog.clusterName=<CLUSTER_NAME> \
    --set datadog.apiKey=<API_KEY> \
    --set datadog.appKey=<APP_KEY> \
    --set datadog.networkMonitoring.enabled=true \
    --version 2.36.1 \
    datadog/datadog
```

## Helpful Commands

```sh
alias tf="terraform"
RPROMPT='$(terraform workspace show)'
RPROMPT='$(kubectl config current-context)'
RPROMPT+='-$(kubectl config view --minify --output "jsonpath={..namespace}")'

terraform init -upgrade
terraform validate
terraform fmt -list=true -write=true -recursive -diff
terraform refresh -var-file=env/$(terraform workspace show).tfvars
terraform plan -var-file=env/$(terraform workspace show).tfvars -out=$(terraform workspace show).tfplan
terraform import -var-file=env/$(tf workspace show).tfvars resource.example resource
terraform output
terraform output -json

doctl registry login
doctl kubernetes cluster kubeconfig save <cluster-id|cluster-name>
doctl compute load-balancer list --format IP,ID,Name,Status
doctl kubernetes cluster registry add <cluster-id|cluster-name>
doctl kubernetes cluster kubeconfig save <cluster-id|cluster-name>

gcloud auth login
gcloud auth application-default login
gcloud container clusters get-credentials <CLUSTER>
gcloud services enable container.googleapis.com --async
gcloud components install gke-gcloud-auth-plugin

kubectl delete pod --field-selector=status.phase==Succeeded --all-namespaces

find . -type f -name "*.tfplan" -print -delete
find . -type d -name ".terraform" -print -prune -exec rm -rf {} +
```

## Cost

Current cost for this project hovers around $12 per month. With ingress configured, the price doubles and is to $24.

| Resource            | Count | Cost per Resource |
| ------------------- | ----- | ----------------- |
| s-1vcpu-2gb droplet | 1     | $12               |
| load balancer       | 0     | $12               |

## DigitalOcean

[![DigitalOcean Referral Badge](https://web-platforms.sfo2.digitaloceanspaces.com/WWW/Badge%203.svg)](https://www.digitalocean.com/?refcode=f157569516fd&utm_campaign=Referral_Invite&utm_medium=Referral_Program&utm_source=badge)
