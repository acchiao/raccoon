resource "kubernetes_namespace" "linkerd" {
  metadata {
    name = "linkerd"
  }
}

resource "helm_release" "linkerd" {
  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  namespace  = kubernetes_namespace.linkerd.metadata[0].name
  version    = "2.11.1"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout
}
