resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  version    = "9.1.5"

  lint    = true
  wait    = var.helm_wait
  timeout = var.helm_timeout

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}
