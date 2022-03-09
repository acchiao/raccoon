provider "kubernetes" {
  host  = data.terraform_remote_state.raccoon.outputs.kubernetes_endpoint
  token = data.terraform_remote_state.raccoon.outputs.kubernetes_kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.raccoon.outputs.kubernetes_kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = data.terraform_remote_state.raccoon.outputs.kubernetes_endpoint
    token = data.terraform_remote_state.raccoon.outputs.kubernetes_kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.terraform_remote_state.raccoon.outputs.kubernetes_kube_config[0].cluster_ca_certificate
    )
  }
}
