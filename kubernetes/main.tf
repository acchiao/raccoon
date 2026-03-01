resource "kubernetes_namespace_v1" "rng" {
  metadata {
    name = "rng"
  }
}

resource "kubernetes_namespace_v1" "tmp" {
  metadata {
    name = "tmp"
  }
}

resource "kubernetes_namespace_v1" "cloudflare" {
  metadata {
    name = "cloudflare"
  }
}

resource "kubernetes_namespace_v1" "sandbox" {
  metadata {
    name = "sandbox"
  }
}

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

resource "kubernetes_namespace_v1" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace_v1.ingress_nginx.metadata[0].name
  version    = var.ingress_nginx_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set = [
    {
      name  = "replicaCount"
      value = var.helm_replica_count
    }
  ]

  # values = [
  #   file("values/ingress-nginx-values.yaml")
  # ]

  depends_on = [
    kubernetes_namespace_v1.ingress_nginx,
  ]
}

resource "kubernetes_namespace_v1" "external_dns" {
  metadata {
    name = "external-dns"
  }
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = kubernetes_namespace_v1.external_dns.metadata[0].name
  version    = var.external_dns_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  # values = [
  #   file("values/external-dns-values.yaml")
  # ]

  set = [
    {
      name  = "rbac.create"
      value = "true"
    },
    {
      name  = "replicaCount"
      value = var.helm_replica_count
    },
    {
      name  = "policy"
      value = "sync"
    },
    {
      name  = "interval"
      value = "1m"
    },
    {
      name  = "provider"
      value = "digitalocean"
    },
    {
      name  = "logLevel"
      value = "error"
    }
  ]

  depends_on = [
    kubernetes_namespace_v1.external_dns,
  ]
}

resource "kubernetes_namespace_v1" "datadog" {
  metadata {
    name = "datadog"
  }
}

resource "kubernetes_namespace_v1" "kubed" {
  metadata {
    name = "kubed"
  }
}

resource "helm_release" "kubed" {
  name       = "kubed"
  repository = "https://charts.appscode.com/stable"
  chart      = "kubed"
  namespace  = kubernetes_namespace_v1.kubed.metadata[0].name
  version    = var.kubed_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set = [
    {
      name  = "enableAnalytics"
      value = "false"
    }
  ]

  depends_on = [
    kubernetes_namespace_v1.kubed,
  ]
}

resource "kubernetes_namespace_v1" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = kubernetes_namespace_v1.cert_manager.metadata[0].name
  version    = var.cert_manager_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set = [
    {
      name  = "installCRDs"
      value = "true"
    },
    {
      name  = "replicaCount"
      value = var.helm_replica_count
    }
  ]

  depends_on = [
    kubernetes_namespace_v1.cert_manager,
  ]
}

resource "kubernetes_namespace_v1" "metrics" {
  metadata {
    name = "metrics"
  }
}

resource "helm_release" "metrics" {
  name       = "metrics"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  namespace  = kubernetes_namespace_v1.metrics.metadata[0].name
  version    = var.metrics_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set = [
    {
      name  = "nameOverride"
      value = "metrics"
    }
  ]

  depends_on = [
    kubernetes_namespace_v1.metrics,
  ]
}

resource "helm_release" "datadog" {
  name       = "datadog"
  repository = "https://helm.datadoghq.com"
  chart      = "datadog"
  namespace  = kubernetes_namespace_v1.datadog.metadata[0].name
  version    = var.datadog_version

  lint          = true
  wait          = var.helm_wait
  timeout       = var.helm_timeout
  recreate_pods = var.helm_recreate_pods

  set = [
    {
      name  = "datadog.clusterName"
      value = "raccoon"
    },
    {
      name  = "datadog.apiKeyExistingSecret"
      value = "datadog"
    },
    {
      name  = "datadog.appKeyExistingSecret"
      value = "datadog"
    },
    {
      name  = "datadog.logs.enabled"
      value = "true"
    },
    {
      name  = "datadog.logs.containerCollectAll"
      value = "true"
    },
    {
      name  = "datadog.logs.containerCollectUsingFiles"
      value = "true"
    },
    {
      name  = "datadog.logs.autoMultiLineDetection"
      value = "true"
    },
    {
      name  = "datadog.apm.portEnabled"
      value = "true"
    },
    {
      name  = "datadog.kubeStateMetricsEnabled"
      value = "false"
    },
    {
      name  = "datadog.kubeStateMetricsCore.enabled"
      value = "true"
    },
    {
      name  = "datadog.kubeStateMetricsCore.ignoreLegacyKSMCheck"
      value = "true"
    },
    {
      name  = "agents.containers.agent.resources.requests.cpu"
      value = "100m"
    },
    {
      name  = "agents.containers.agent.resources.limits.cpu"
      value = "150m"
    },
    {
      name  = "agents.containers.agent.resources.requests.memory"
      value = "100Mi"
    },
    {
      name  = "agents.containers.agent.resources.limits.memory"
      value = "150Mi"
    },
    {
      name  = "clusterAgent.resources.requests.cpu"
      value = "100m"
    },
    {
      name  = "clusterAgent.resources.limits.cpu"
      value = "150m"
    },
    {
      name  = "clusterAgent.resources.requests.memory"
      value = "100Mi"
    },
    {
      name  = "clusterAgent.resources.limits.memory"
      value = "150Mi"
    },
    {
      name  = "datadog.processAgent.enabled"
      value = "false"
    },
    {
      name  = "datadog.processAgent.processCollection"
      value = "false"
    },
    {
      name  = "datadog.networkMonitoring.enabled"
      value = "true"
    },
    {
      name  = "datadog.collectEvents"
      value = "true"
    },
    {
      name  = "datadog.clusterChecks.enabled"
      value = "true"
    },
    {
      name  = "datadog.helmCheck.enabled"
      value = "true"
    },
    {
      name  = "datadog.serviceMonitoring.enabled"
      value = "true"
    },
    {
      name  = "agents.containers.agent.env[0].name"
      value = "DD_CONTAINER_EXCLUDE"
    },
    {
      name  = "agents.containers.agent.env[0].value"
      value = "image:gcr.io/datadoghq/.*"
    },
    {
      name  = "datadog.containerExclude"
      value = "image:gcr.io/datadoghq/.*"
    },
    {
      name  = "clusterAgent.enabled"
      value = "true"
    },
    {
      name  = "clusterChecksRunner.enabled"
      value = "false"
    }
  ]

  depends_on = [
    kubernetes_namespace_v1.datadog,
  ]
}

resource "kubernetes_namespace_v1" "linkerd" {
  metadata {
    name = "linkerd"
  }
}

resource "helm_release" "linkerd" {
  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  chart      = "linkerd2"
  namespace  = kubernetes_namespace_v1.linkerd.metadata[0].name
  version    = var.linkerd_version

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set = [
    {
      name  = "installNamespace"
      value = "false"
    },
    {
      name  = "namespace"
      value = kubernetes_namespace_v1.linkerd.metadata[0].name
    },
    # {
    #   name  = "identityTrustAnchorsPEM"
    #   value = file("certificates/ca.crt")
    # },
    # {
    #   name  = "identity.issuer.tls.crtPEM"
    #   value = file("certificates/issuer.crt")
    # },
    # {
    #   name  = "identity.issuer.tls.keyPEM"
    #   value = file("certificates/issuer.key")
    # }
  ]

  depends_on = [
    kubernetes_namespace_v1.linkerd,
  ]
}
