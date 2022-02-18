# Imported resource
resource "kubernetes_namespace" "kube_system" {
  metadata {
    name = "kube-system"
    labels = {
      "istio-injection" = "disabled"
    }
  }
}

# Imported resource
resource "kubernetes_namespace" "kube_node_lease" {
  metadata {
    name = "kube-node-lease"
  }
}

# Imported resource
resource "kubernetes_namespace" "kube_public" {
  metadata {
    name = "kube-public"
  }
}

# Imported resource
resource "kubernetes_namespace" "default" {
  metadata {
    name = "default"
  }
}

resource "kubernetes_namespace" "sandbox" {
  metadata {
    name = "sandbox"
  }
}
