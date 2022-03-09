
# # resource "kubernetes_namespace" "external_dns_cloudflare" {
# #   metadata {
# #     name = "external-dns-cloudflare"
# #   }
# # }

# resource "helm_release" "external_dns_cloudflare" {
#   name       = "external-dns-cloudflare"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "external-dns"
#   namespace  = kubernetes_namespace.external_dns.metadata[0].name
#   version    = var.external_dns_version

#   lint          = true
#   wait          = var.helm_wait
#   timeout       = var.helm_timeout
#   recreate_pods = true

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
#     kubernetes_namespace.external_dns,
#   ]
# }

# # resource "kubernetes_namespace" "haproxy" {
# #   metadata {
# #     name = "haproxy"
# #   }
# # }

# # resource "helm_release" "haproxy" {
# #   name       = "haproxy"
# #   repository = "https://charts.bitnami.com/bitnami"
# #   chart      = "haproxy"
# #   namespace  = kubernetes_namespace.haproxy.metadata[0].name
# #   version    = var.haproxy_version

# #   lint          = true
# #   wait          = var.helm_wait
# #   timeout       = var.helm_timeout
# #   recreate_pods = true

# #   depends_on = [
# #     kubernetes_namespace.haproxy,
# #   ]
# # }

# # resource "kubernetes_namespace" "linkerd" {
# #   metadata {
# #     name = "linkerd"
# #   }
# # }

# # resource "helm_release" "linkerd" {
# #   name       = "linkerd"
# #   repository = "https://helm.linkerd.io/stable"
# #   chart      = "linkerd2"
# #   namespace  = kubernetes_namespace.linkerd.metadata[0].name
# #   version    = var.linkerd_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   set {
# #     name  = "installNamespace"
# #     value = "false"
# #   }

# #   set {
# #     name  = "namespace"
# #     value = kubernetes_namespace.linkerd.metadata[0].name
# #   }

# #   set {
# #     name  = "identityTrustAnchorsPEM"
# #     value = file("certificates/ca.crt")
# #   }

# #   set {
# #     name  = "identity.issuer.tls.crtPEM"
# #     value = file("certificates/issuer.crt")
# #   }

# #   set {
# #     name  = "identity.issuer.tls.keyPEM"
# #     value = file("certificates/issuer.key")
# #   }

# #   depends_on = [
# #     kubernetes_namespace.linkerd,
# #   ]
# # }

# # resource "helm_release" "linkerd_viz" {
# #   name       = "linkerd-viz"
# #   repository = "https://helm.linkerd.io/stable"
# #   chart      = "linkerd-viz"
# #   namespace  = kubernetes_namespace.linkerd.metadata[0].name
# #   version    = "2.11.1"

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   set {
# #     name  = "installNamespace"
# #     value = "false"
# #   }

# #   set {
# #     name  = "namespace"
# #     value = kubernetes_namespace.linkerd.metadata[0].name
# #   }

# #   depends_on = [
# #     kubernetes_namespace.linkerd,
# #     helm_release.linkerd,
# #   ]
# # }

# # resource "kubernetes_namespace" "istio" {
# #   metadata {
# #     name = "istio-system"
# #   }
# # }

# # resource "helm_release" "istio_base" {
# #   name       = "istio-base"
# #   repository = "https://istio-release.storage.googleapis.com/charts"
# #   chart      = "base"
# #   namespace  = kubernetes_namespace.istio.metadata[0].name
# #   version    = var.istio_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   depends_on = [
# #     kubernetes_namespace.istio,
# #   ]
# # }

# # resource "helm_release" "istiod" {
# #   name       = "istiod"
# #   repository = "https://istio-release.storage.googleapis.com/charts"
# #   chart      = "istiod"
# #   namespace  = kubernetes_namespace.istio.metadata[0].name
# #   version    = var.istio_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   depends_on = [
# #     kubernetes_namespace.istio,
# #     helm_release.istio_base,
# #   ]
# # }

# # resource "helm_release" "istio_ingress" {
# #   name       = "istio-ingress"
# #   repository = "https://istio-release.storage.googleapis.com/charts"
# #   chart      = "gateway"
# #   namespace  = kubernetes_namespace.istio.metadata[0].name
# #   version    = var.istio_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   depends_on = [
# #     kubernetes_namespace.istio,
# #     helm_release.istio_base,
# #     helm_release.istiod,
# #   ]
# # }

# # resource "helm_release" "istio_cni" {
# #   name       = "istio-cni"
# #   repository = "https://istio-release.storage.googleapis.com/charts"
# #   chart      = "cni"
# #   namespace  = kubernetes_namespace.istio.metadata[0].name
# #   version    = var.istio_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   depends_on = [
# #     kubernetes_namespace.istio,
# #     helm_release.istio_base,
# #     helm_release.istiod,
# #   ]
# # }

# # resource "kubernetes_namespace" "traefik" {
# #   metadata {
# #     name = "traefik"
# #   }
# # }

# # resource "helm_release" "traefik" {
# #   name       = "traefik"
# #   repository = "https://helm.traefik.io/traefik"
# #   chart      = "traefik"
# #   namespace  = kubernetes_namespace.traefik.metadata[0].name
# #   version    = var.traefik_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   depends_on = [
# #     kubernetes_namespace.traefik,
# #   ]
# # }

# # resource "kubernetes_namespace" "calico" {
# #   metadata {
# #     name = "calico-system"
# #   }
# # }

# # resource "helm_release" "calico" {
# #   name       = "calico"
# #   repository = "https://projectcalico.docs.tigera.io/charts"
# #   chart      = "tigera-operator"
# #   namespace  = kubernetes_namespace.calico.metadata[0].name
# #   version    = var.calico_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   depends_on = [
# #     kubernetes_namespace.calico,
# #   ]
# # }

# # resource "helm_release" "coredns" {
# #   name       = "coredns"
# #   repository = "https://coredns.github.io/helm"
# #   chart      = "coredns"
# #   namespace  = "kube-system"
# #   version    = var.coredns_version

# #   lint    = true
# #   wait    = var.helm_wait
# #   timeout = var.helm_timeout

# #   set {
# #     name  = "providers.kubernetesIngress.enabled"
# #     value = "false"
# #   }
# # }
