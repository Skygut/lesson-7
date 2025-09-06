 

# Create namespace for ArgoCD
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
    labels = {
      name        = var.argocd_namespace
      environment = "infrastructure"
      managed-by  = "terraform"
    }
  }
}

# Deploy ArgoCD via Helm
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_version
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  values = [
    file(var.argocd_values_file)
  ]

  depends_on = [kubernetes_namespace.argocd]

  # Wait for deployment to be ready
  wait          = true
  wait_for_jobs = true
  timeout       = 600

  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = false
  }
}

 

