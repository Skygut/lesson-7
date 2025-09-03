provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # або використовуйте data з remote backend
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  version    = "5.51.6" # актуальну перевірити

  values = [
    file("${path.module}/values/argocd-values.yaml")
  ]

  create_namespace = false
}
