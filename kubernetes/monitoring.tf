# resource "kubernetes_namespace" "falco" {
#   metadata {
#     name = "falco"
#   }
# }

# resource "helm_release" "falco" {
#   name       = "falco"
#   repository = "https://falcosecurity.github.io/charts"
#   chart      = "falco"
#   namespace  = kubernetes_namespace.falco.metadata[0].name
#   version    = var.falco_version

#   lint    = true
#   wait    = var.helm_wait
#   timeout = var.helm_timeout

#   depends_on = [
#     kubernetes_namespace.falco,
#   ]
# }

# resource "kubernetes_namespace" "kubernetes_dashboard" {
#   metadata {
#     name = "kubernetes-dashboard"
#   }
# }

# resource "helm_release" "kubernetes_dashboard" {
#   name       = "kubernetes-dashboard"
#   repository = "https://kubernetes.github.io/dashboard"
#   chart      = "kubernetes-dashboard"
#   namespace  = kubernetes_namespace.kubernetes_dashboard.metadata[0].name
#   version    = var.kubernetes_dashboard_version

#   lint    = true
#   wait    = var.helm_wait
#   timeout = var.helm_timeout

#   depends_on = [
#     kubernetes_namespace.kubernetes_dashboard,
#   ]
# }

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
