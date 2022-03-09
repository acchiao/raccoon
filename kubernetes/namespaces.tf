resource "kubernetes_namespace" "sandbox" {
  metadata {
    name = "sandbox"
  }
}

resource "kubernetes_namespace" "hello_world" {
  metadata {
    name = "hello-world"
  }
}

resource "kubernetes_namespace" "echo" {
  metadata {
    name = "echo"
  }
}

resource "kubernetes_namespace" "cloudflare" {
  metadata {
    name = "cloudflare"
  }
}

resource "kubernetes_namespace" "acchiao" {
  metadata {
    name = "acchiao"
  }
}

resource "kubernetes_namespace" "limelight" {
  metadata {
    name = "limelight"
  }
}

resource "kubernetes_namespace" "nutshell" {
  metadata {
    name = "nutshell"
  }
}
