resource "kubernetes_namespace" "meilisearch" {
  metadata {
    name = "meilisearch"
  }
}

resource "helm_release" "meilisearch" {
  name       = "meilisearch"
  repository = "https://meilisearch.github.io/meilisearch-kubernetes"
  chart      = "meilisearch"
  namespace  = kubernetes_namespace.meilisearch.metadata[0].name
  version    = "0.1.26"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "environment.MEILI_NO_ANALYTICS"
    value = "true"
  }

  set {
    name  = "ingress.enabled"
    value = "false"
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "environment.MEILI_ENV"
    value = "production"
  }
}
