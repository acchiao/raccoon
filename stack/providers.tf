provider "digitalocean" {}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.raccoon.endpoint
  token = digitalocean_kubernetes_cluster.raccoon.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.raccoon.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host  = digitalocean_kubernetes_cluster.raccoon.endpoint
    token = digitalocean_kubernetes_cluster.raccoon.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.raccoon.kube_config[0].cluster_ca_certificate
    )
  }
}
