resource "kubernetes_namespace" "kubed" {
  metadata {
    name = "kubed"
  }
}

resource "helm_release" "kubed" {
  name       = "kubed"
  repository = "https://charts.appscode.com/stable/"
  chart      = "kubed"
  namespace  = kubernetes_namespace.kubed.metadata[0].name
  version    = var.kubed_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "enableAnalytics"
    value = "false"
  }

  depends_on = [
    kubernetes_namespace.kubed,
  ]
}
