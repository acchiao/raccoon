provider "kubernetes" {
  host  = data.tfe_outputs.raccoon.values.kubernetes_endpoint
  token = data.tfe_outputs.raccoon.values.kubernetes_kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.tfe_outputs.raccoon.values.kubernetes_kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes = {
    host  = data.tfe_outputs.raccoon.values.kubernetes_endpoint
    token = data.tfe_outputs.raccoon.values.kubernetes_kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.tfe_outputs.raccoon.values.kubernetes_kube_config[0].cluster_ca_certificate
    )
  }
}
