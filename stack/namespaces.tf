resource "kubernetes_namespace" "external_dns" {
  metadata {
    name        = "external-dns"
    labels      = {}
    annotations = {}
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name        = "cert-manager"
    labels      = {}
    annotations = {}
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name        = "ingress-nginx"
    labels      = {}
    annotations = {}
  }
}

resource "kubernetes_namespace" "sandbox" {
  metadata {
    name        = "sandbox"
    labels      = {}
    annotations = {}
  }
}
