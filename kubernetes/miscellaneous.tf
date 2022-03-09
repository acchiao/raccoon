# resource "kubernetes_namespace" "meilisearch" {
#   metadata {
#     name = "meilisearch"
#   }
# }

# resource "helm_release" "meilisearch" {
#   name       = "meilisearch"
#   repository = "https://meilisearch.github.io/meilisearch-kubernetes"
#   chart      = "meilisearch"
#   namespace  = kubernetes_namespace.meilisearch.metadata[0].name
#   version    = var.meilisearch_version

#   lint          = true
#   wait          = var.helm_wait
#   timeout       = var.helm_timeout
#   recreate_pods = true

#   set {
#     name  = "environment.MEILI_NO_ANALYTICS"
#     value = "true"
#   }

#   set {
#     name  = "ingress.enabled"
#     value = "false"
#   }

#   set {
#     name  = "replicaCount"
#     value = "1"
#   }

#   set {
#     name  = "environment.MEILI_ENV"
#     value = "production"
#   }

#   depends_on = [
#     kubernetes_namespace.meilisearch,
#   ]
# }

# resource "kubernetes_namespace" "oauth2_proxy" {
#   metadata {
#     name = "oauth2-proxy"
#   }
# }

# resource "helm_release" "oauth2_proxy" {
#   name       = "oauth2-proxy"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "oauth2-proxy"
#   namespace  = kubernetes_namespace.oauth2_proxy.metadata[0].name
#   version    = var.oauth2_proxy_version

#   lint          = true
#   wait          = var.helm_wait
#   timeout       = var.helm_timeout
#   recreate_pods = true

#   set {
#     name  = "redis.enabled"
#     value = "false"
#   }

#   depends_on = [
#     kubernetes_namespace.oauth2_proxy,
#   ]
# }
