resource "kubernetes_namespace" "sandbox" {
  metadata {
    name = "sandbox"
  }
}

# resource "kubernetes_namespace" "kube_system" {
#   metadata {
#     name = "kube-system"
#     labels = {
#       "istio-injection" = "disabled"
#     }
#   }
# }

# resource "kubernetes_namespace" "kube_node_lease" {
#   metadata {
#     name = "kube-node-lease"
#   }
# }

# resource "kubernetes_namespace" "kube_public" {
#   metadata {
#     name = "kube-public"
#   }
# }

# resource "kubernetes_namespace" "default" {
#   metadata {
#     name = "default"
#   }
# }
