resource "kubernetes_namespace" "metrics" {
  count = var.enable_metrics ? 1 : 0

  metadata {
    name = "metrics"
  }
}

resource "helm_release" "metrics" {
  count = var.enable_metrics ? 1 : 0

  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = kubernetes_namespace.metrics[count.index].metadata[0].name
  version    = var.metrics_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  depends_on = [
    kubernetes_namespace.metrics,
  ]
}

resource "kubernetes_namespace" "external_dns" {
  count = var.enable_external_dns ? 1 : 0

  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external_dns" {
  count = var.enable_external_dns ? 1 : 0

  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = kubernetes_namespace.external_dns[count.index].metadata[0].name
  version    = var.external_dns_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  values = [
    file("values/external-dns-values.yaml")
  ]

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "interval"
    value = "1m"
  }

  set {
    name  = "provider"
    value = "digitalocean"
  }

  depends_on = [
    kubernetes_namespace.external_dns,
  ]
}

resource "kubernetes_namespace" "cert_manager" {
  count = var.enable_cert_manager ? 1 : 0

  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  count = var.enable_cert_manager ? 1 : 0

  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager[count.index].metadata[0].name
  version    = var.cert_manager_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.cert_manager,
  ]
}

resource "kubernetes_namespace" "kubed" {
  count = var.enable_kubed ? 1 : 0

  metadata {
    name = "kubed"
  }
}

resource "helm_release" "kubed" {
  count = var.enable_kubed ? 1 : 0

  name       = "kubed"
  repository = "https://charts.appscode.com/stable/"
  chart      = "kubed"
  namespace  = kubernetes_namespace.kubed[count.index].metadata[0].name
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

resource "kubernetes_namespace" "ingress_nginx" {
  count = var.enable_ingress_nginx ? 1 : 0

  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  count = var.enable_ingress_nginx ? 1 : 0

  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = kubernetes_namespace.ingress_nginx[count.index].metadata[0].name
  version    = var.ingress_nginx_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.ingress_nginx,
  ]
}

resource "kubernetes_namespace" "monitoring" {
  count = var.enable_thanos ? 1 : 0

  metadata {
    name = "thanos"
  }
}

resource "helm_release" "thanos" {
  count = var.enable_thanos ? 1 : 0

  name       = "thanos"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "thanos"
  namespace  = kubernetes_namespace.monitoring[count.index].metadata[0].name
  version    = var.thanos_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  depends_on = [
    kubernetes_namespace.monitoring,
  ]
}

resource "kubernetes_namespace" "linkerd" {
  count = var.enable_linkerd ? 1 : 0

  metadata {
    name = "linkerd"
  }
}

resource "helm_release" "linkerd" {
  count = var.enable_linkerd ? 1 : 0

  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  namespace  = kubernetes_namespace.linkerd[count.index].metadata[0].name
  version    = var.linkerd_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "installNamespace"
    value = "false"
  }

  set {
    name  = "namespace"
    value = kubernetes_namespace.linkerd[count.index].metadata[0].name
  }

  set {
    name  = "identityTrustAnchorsPEM"
    value = file("certificates/ca.crt")
  }

  set {
    name  = "identity.issuer.tls.crtPEM"
    value = file("certificates/issuer.crt")
  }

  set {
    name  = "identity.issuer.tls.keyPEM"
    value = file("certificates/issuer.key")
  }

  depends_on = [
    kubernetes_namespace.linkerd,
  ]
}

resource "helm_release" "linkerd_viz" {
  count = var.enable_linkerd ? 1 : 0

  name       = "linkerd-viz"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd-viz"
  namespace  = kubernetes_namespace.linkerd[count.index].metadata[0].name
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
    value = kubernetes_namespace.linkerd[count.index].metadata[0].name
  }

  depends_on = [
    kubernetes_namespace.linkerd,
    helm_release.linkerd,
  ]
}

resource "kubernetes_namespace" "meilisearch" {
  count = var.enable_meilisearch ? 1 : 0

  metadata {
    name = "meilisearch"
  }
}

resource "helm_release" "meilisearch" {
  count = var.enable_meilisearch ? 1 : 0

  name       = "meilisearch"
  repository = "https://meilisearch.github.io/meilisearch-kubernetes"
  chart      = "meilisearch"
  namespace  = kubernetes_namespace.meilisearch[count.index].metadata[0].name
  version    = var.meilisearch_version

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

  depends_on = [
    kubernetes_namespace.meilisearch,
  ]
}
