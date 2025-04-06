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
  source = "./modules/vpc"
  name   = var.name
}

module "eks" {
  source       = "./modules/eks"
  name         = var.name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  cluster_name = "${var.name}-cluster"
}

module "ec2_worker" {
  source       = "./modules/ec2_worker"
  name         = var.name
  subnet_id    = module.vpc.public_subnet_ids[0]
  cluster_name = module.eks.cluster_name
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
          image = "nginx" # Replace with your container image
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

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = var.name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

