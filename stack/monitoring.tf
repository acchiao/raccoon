resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "metrics" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = var.metrics_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  depends_on = [
    kubernetes_namespace.monitoring,
  ]
}

# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-prometheus-stack"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name
#   version    = var.prometheus_version

#   lint    = true
#   wait    = var.helm_wait
#   timeout = var.helm_timeout

#   depends_on = [
#     kubernetes_namespace.monitoring,
#   ]
# }

# resource "helm_release" "thanos" {
#   name       = "thanos"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "thanos"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name
#   version    = var.thanos_version

#   lint    = true
#   wait    = var.helm_wait
#   timeout = var.helm_timeout

#   depends_on = [
#     kubernetes_namespace.monitoring,
#   ]
# }

# resource "helm_release" "fluent_bit" {
#   name       = "fluent-bit"
#   repository = "https://fluent.github.io/helm-charts"
#   chart      = "fluent-bit"
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name
#   version    = var.fluent_bit_version

#   lint    = true
#   wait    = var.helm_wait
#   timeout = var.helm_timeout

#   depends_on = [
#     kubernetes_namespace.monitoring,
#   ]
# }
