# Architecture

---

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.4 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.17.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.17.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [digitalocean_container_registry.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/container_registry) | resource |
| [digitalocean_domain.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/domain) | resource |
| [digitalocean_project.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project) | resource |
| [digitalocean_project_resources.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_vpc.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [random_id.registry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.vpc](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the DigitalOcean domain resource. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The project environment. | `string` | n/a | yes |
| <a name="input_project_environment"></a> [project\_environment](#input\_project\_environment) | The DigitalOcean project environment. The possible values are: `Development`, `Staging`, `Production`. | `string` | `"Production"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The DigitalOcean project name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | See `doctl kubernetes options regions`. | `string` | `"nyc1"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | The DigitalOcean project name. |
| <a name="output_region"></a> [region](#output\_region) | The DigitalOcean resource region. |
| <a name="output_registry_name"></a> [registry\_name](#output\_registry\_name) | The DigitalOcean container registry name. |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The DigitalOcean VPC name. |

---

## Stack

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.4 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.17.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.17.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_project.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project) | resource |
| [digitalocean_project_resources.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_vpc.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [random_id.cluster](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.pool](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.vpc](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [digitalocean_kubernetes_versions.prefix](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_versions) | data source |
| [digitalocean_project.raccoon](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |
| [terraform_remote_state.raccoon](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scale"></a> [auto\_scale](#input\_auto\_scale) | Enable auto-scaling for the Kubernetes cluster within given min/max node range. | `bool` | `true` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | See `doctl kubernetes options sizes`. | `string` | `"s-1vcpu-2gb"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The project environment. | `string` | n/a | yes |
| <a name="input_max_nodes"></a> [max\_nodes](#input\_max\_nodes) | If auto-scaling is enabled, this represents the maximum number of nodes that the node pool can be scaled up to. | `number` | `1` | no |
| <a name="input_min_nodes"></a> [min\_nodes](#input\_min\_nodes) | If auto-scaling is enabled, this represents the minimum number of nodes that the node pool can be scaled down to. | `number` | `1` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The number of Droplet instances in the node pool. | `number` | `1` | no |
| <a name="input_project_environment"></a> [project\_environment](#input\_project\_environment) | The DigitalOcean project environment. The possible values are: `Development`, `Staging`, `Production`. | `string` | `"Production"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The DigitalOcean project name. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | See `doctl kubernetes options regions`. | `string` | `"nyc1"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The DigitalOcean Kubernetes cluster name. |
| <a name="output_cluster_version"></a> [cluster\_version](#output\_cluster\_version) | The DigitalOcean Kubernetes cluster version. |
| <a name="output_node_count"></a> [node\_count](#output\_node\_count) | The current node count. |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | The DigitalOcean project name. |
