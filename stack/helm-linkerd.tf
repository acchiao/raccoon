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

  set {
    name  = "installNamespace"
    value = "false"
  }

  set {
    name  = "namespace"
    value = kubernetes_namespace.linkerd.metadata[0].name
  }

  set {
    name  = "identityTrustAnchorsPEM"
    value = file("ca.crt")
  }

  set {
    name  = "identity.issuer.tls.crtPEM"
    value = file("issuer.crt")
  }

  set {
    name  = "identity.issuer.tls.keyPEM"
    value = file("issuer.key")
  }
}

resource "helm_release" "linkerd_viz" {
  name       = "linkerd-viz"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-viz"
  namespace  = kubernetes_namespace.linkerd.metadata[0].name
  version    = "2.11.1"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "installNamespace"
    value = "false"
  }

  set {
    name  = "namespace"
    value = kubernetes_namespace.linkerd.metadata[0].name
  }

  depends_on = [
    helm_release.linkerd,
  ]
}
