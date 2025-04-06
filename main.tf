terraform {
  required_version = ">= 1.3.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "eks/env-name/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = "${var.name}-cluster"
  cluster_version = "1.28"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 1
    }
  }
}

resource "kubernetes_deployment" "web" {
  metadata {
    name      = "web-app"
    namespace = "default"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "web"
      }
    }

    template {
      metadata {
        labels = {
          app = "web"
        }
      }

      spec {
        container {
          name  = "web"
          image = "nginx"
          ports {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web" {
  metadata {
    name = "web-lb"
  }

  spec {
    selector = {
      app = "web"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
    }
  }
}
