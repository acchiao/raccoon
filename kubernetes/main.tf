resource "kubernetes_config_map" "coredns_custom" {
  metadata {
    name      = "coredns-custom"
    namespace = "kube-system"
  }

  data = {
    "empty.override" = "# empty"
    "empty.server"   = "# empty"
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  version    = var.ingress_nginx_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set {
    name  = "replicaCount"
    value = var.helm_replica_count
  }

  values = [
    file("values/ingress-nginx-values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.ingress_nginx,
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
    value = "60s"
  }

  set {
    name  = "provider"
    value = "digitalocean"
  }

  depends_on = [
    kubernetes_namespace.external_dns,
  ]
}

resource "kubernetes_namespace" "datadog" {
  metadata {
    name = "datadog"
  }
}

resource "helm_release" "datadog" {
  name       = "datadog"
  repository = "https://helm.datadoghq.com"
  chart      = "datadog"
  namespace  = kubernetes_namespace.datadog.metadata[0].name
  version    = var.datadog_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set {
    name  = "datadog.apiKeyExistingSecret"
    value = "datadog"
  }

  set {
    name  = "datadog.appKeyExistingSecret"
    value = "datadog"
  }

  set {
    name  = "datadog.logs.enabled"
    value = "true"
  }

  set {
    name  = "datadog.logs.containerCollectAll"
    value = "true"
  }

  set {
    name  = "datadog.kubeStateMetricsEnabled"
    value = "false"
  }

  set {
    name  = "datadog.kubeStateMetricsCore.enabled"
    value = "true"
  }

  set {
    name  = "datadog.kubeStateMetricsCore.ignoreLegacyKSMCheck"
    value = "true"
  }

  set {
    name  = "agents.containers.agent.env[0].name"
    value = "DD_CONTAINER_EXCLUDE"
  }

  set {
    name  = "agents.containers.agent.env[0].value"
    value = "image:gcr.io/datadoghq/.*"
  }

  depends_on = [
    kubernetes_namespace.datadog,
  ]
}

# resource "kubernetes_namespace" "metrics" {
#   metadata {
#     name = "metrics"
#   }
# }

# resource "helm_release" "metrics" {
#   name       = "metrics"
#   repository = "https://kubernetes-sigs.github.io/metrics-server"
#   chart      = "metrics-server"
#   namespace  = kubernetes_namespace.metrics.metadata[0].name
#   version    = var.metrics_version

#   lint    = true
#   wait    = var.helm_wait
#   timeout = var.helm_timeout

#   set {
#     name  = "nameOverride"
#     value = "metrics"
#   }

#   depends_on = [
#     kubernetes_namespace.metrics,
#   ]
# }
