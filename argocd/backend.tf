# For production use, consider using remote state
# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "argocd/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-state-lock"
#   }
# }

# Local backend for development
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

