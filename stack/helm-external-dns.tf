resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = kubernetes_namespace.external_dns.metadata[0].name
  version    = "6.1.5"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  values = [
    "${file("values/external-dns-values.yaml")}"
  ]

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name = "interval"
    value = "1m"
  }

  set {
    name  = "provider"
    value = "digitalocean"
  }
}
