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
