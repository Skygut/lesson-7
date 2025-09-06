output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "argocd_server_service" {
  description = "ArgoCD server service name"
  value       = "${helm_release.argocd.name}-server"
}

output "argocd_server_port" {
  description = "ArgoCD server port"
  value       = 80
}

output "argocd_admin_password_secret" {
  description = "ArgoCD admin password secret name"
  value       = "${helm_release.argocd.name}-initial-admin-secret"
}

output "kubectl_port_forward_command" {
  description = "Command to port-forward ArgoCD UI"
  value       = "kubectl port-forward svc/${helm_release.argocd.name}-server -n ${var.argocd_namespace} 8080:80"
}

output "argocd_ui_url" {
  description = "Local ArgoCD UI URL after port-forward"
  value       = "http://localhost:8080"
}


output "get_admin_password_command" {
  description = "Command to get ArgoCD admin password"
  value       = "kubectl -n ${var.argocd_namespace} get secret ${helm_release.argocd.name}-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo"
}

 

