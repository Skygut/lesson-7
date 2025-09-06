variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Kubeconfig context name"
  type        = string
  default     = null
}

variable "argocd_namespace" {
  description = "Kubernetes namespace for ArgoCD"
  type        = string
  default     = "infra-tools"
}

variable "argocd_version" {
  description = "ArgoCD Helm chart version"
  type        = string
  default     = "5.46.8"
}

variable "argocd_values_file" {
  description = "Path to ArgoCD values file"
  type        = string
  default     = "./values/argocd-values.yaml"
}


variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "MLOps-ArgoCD-Demo"
    Environment = "dev"
    ManagedBy   = "terraform"
    Owner       = "goit-student"
  }
}

