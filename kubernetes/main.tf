resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "metrics" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
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

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  version    = var.cert_manager_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "replicaCount"
    value = var.helm_replica_count
  }

  depends_on = [
    kubernetes_namespace.cert_manager,
  ]
}

# resource "kubernetes_namespace" "cert_manager_cloudflare" {
#   metadata {
#     name = "cert-manager-cloudflare"
#   }
# }

# resource "helm_release" "cert_manager_cloudflare" {
#   name       = "cert-manager-cloudflare"
#   repository = "https://charts.jetstack.io"
#   chart      = "cert-manager"
#   namespace  = kubernetes_namespace.cert_manager_cloudflare.metadata[0].name
#   version    = var.cert_manager_version

#   lint          = true
#   wait          = var.helm_wait
#   timeout       = var.helm_timeout
#   recreate_pods = var.helm_recreate_pods

#   set {
#     name  = "installCRDs"
#     value = "false"
#   }

#   depends_on = [
#     kubernetes_namespace.cert_manager_cloudflare,
#   ]
# }

resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = "nginx-ingress"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "raccoon"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = kubernetes_namespace.nginx_ingress.metadata[0].name
  version    = var.nginx_ingress_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set {
    name  = "replicaCount"
    value = var.helm_replica_count
  }

  values = [
    file("values/nginx-ingress-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.nginx_ingress,
  ]
}

resource "kubernetes_namespace" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = kubernetes_namespace.external_dns.metadata[0].name
  version    = var.external_dns_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  values = [
    file("values/external-dns-values.yaml")
  ]

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "replicaCount"
    value = var.helm_replica_count
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "interval"
    value = "30s"
  }

  set {
    name  = "provider"
    value = "digitalocean"
  }

  depends_on = [
    kubernetes_namespace.external_dns,
  ]
}

# resource "kubernetes_namespace" "external_dns_cloudflare" {
#   metadata {
#     name = "external-dns-cloudflare"
#   }
# }

# resource "helm_release" "external_dns_cloudflare" {
#   name       = "external-dns-cloudflare"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "external-dns"
#   namespace  = kubernetes_namespace.external_dns_cloudflare.metadata[0].name
#   version    = var.external_dns_version

#   lint          = true
#   wait          = var.helm_wait
#   timeout       = var.helm_timeout
#   recreate_pods = var.helm_recreate_pods

#   values = [
#     file("values/external-dns-values.yaml")
#   ]

#   set {
#     name  = "rbac.create"
#     value = "true"
#   }

#   set {
#     name  = "policy"
#     value = "sync"
#   }

#   set {
#     name  = "interval"
#     value = "30s"
#   }

#   set {
#     name  = "provider"
#     value = "cloudflare"
#   }

#   depends_on = [
#     kubernetes_namespace.external_dns_cloudflare,
#   ]
# }

resource "kubernetes_namespace" "kubed" {
  metadata {
    name = "kubed"
  }
}

resource "helm_release" "kubed" {
  name       = "kubed"
  repository = "https://charts.appscode.com/stable"
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