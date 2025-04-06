# versions.tf
terraform {
  required_version = "= 1.3.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
