terraform {
  backend "s3" {
    bucket = "my-tf-state"
    key    = "argocd/terraform.tfstate"
    region = "eu-central-1"
  }
}
