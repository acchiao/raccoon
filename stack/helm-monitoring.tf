resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "thanos" {
  name       = "thanos"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "thanos"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "9.0.4"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout
}
