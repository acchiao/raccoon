resource "kubernetes_namespace" "metrics" {
  metadata {
    name = "metrics"
  }
}

resource "helm_release" "metrics" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = kubernetes_namespace.metrics.metadata[0].name
  version    = "3.8.1"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout
}
