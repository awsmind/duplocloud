# duplocloud
This repo is designed to construct a simple Terraform project that will exercise  knowledge of Terraform and AWS
This task aims to build a simple Terraform project that will exercise your knowledge of
Terraform and AWS.
Project specification
●
Must use Terraform => 1.3.3
●
You can use any publicly available Terraform Modules
●
You must be able to apply the Terraform project multiple times within a single
AWS Region to create multiple environments
●
Terraform project must create the following resources
○
VPC
○
EKS
○
EC2 instance as EKS worker node
○
Any container running on EKS with a web interface
○
Load balancer that exposes the web interface of the container
●
Documentation that would enable a software developer who is not proficient in
the following to be able to perform the deployment:
○
AWS
○
Infrastructure as Code
○
general DevOps
Timeline
●
Turnaround time for delivering this assignment is 48 hours
How to submit
●
Create a public Git repository and share the link with us

### Summary of the Terraform Project for AWS

This project aims to create an infrastructure using **Terraform** and **AWS** to set up a basic Kubernetes (EKS) cluster with worker nodes, a web application, and a load balancer that exposes the web interface. The project will be repeatable, allowing multiple environments to be created within the same AWS region.

### Project Specification

#### 1. **Terraform Version**:  
   - Use Terraform 1.3.3 for this project.

#### 2. **Publicly Available Modules**:  
   - You are allowed to use publicly available Terraform modules to simplify your work.

#### 3. **Multiple Environment Setup**:  
   - The project must support the ability to be applied multiple times in the same AWS region, enabling the creation of different environments (e.g., dev, test, prod).

#### 4. **Required Resources**:
   - **VPC (Virtual Private Cloud)**: Set up a VPC where all resources (EKS, EC2, Load Balancer) will reside.
   - **EKS (Elastic Kubernetes Service)**: Set up a Kubernetes cluster on AWS using EKS.
   - **EC2 Instance as EKS Worker Node**: Create EC2 instances that will serve as worker nodes in the EKS cluster.
   - **Container Running on EKS**: Deploy a simple container (such as a web application) on the EKS cluster that has a web interface.
   - **Load Balancer**: Set up a Load Balancer that will expose the web interface of the container deployed on EKS.

#### 5. **Documentation**:  
   - Provide clear documentation that explains the process to deploy the infrastructure. The documentation should be tailored for software developers who may not be familiar with:
     - AWS services
     - Infrastructure as Code concepts
     - General DevOps principles
     
   The documentation should ideally cover the following:
   - **Prerequisites**: Install Terraform, AWS CLI, and other necessary tools.
   - **Step-by-Step Instructions**: How to initialize and apply the Terraform project to deploy the infrastructure.
   - **Understanding of the Components**: Brief explanation of each resource (VPC, EKS, EC2, Load Balancer, etc.) and its role in the architecture.
   - **Troubleshooting Tips**: Common issues that may arise and their solutions.
  
### Timeline
- **48 hours**: Complete the project and submit it.

### How to Submit
1. Create a **public Git repository** (on GitHub, GitLab, etc.).
2. Share the link to the repository for review.

---

### Steps to Complete the Project

1. **Set up Terraform Configuration Files**:  
   - **main.tf**: Main configuration that includes the setup for VPC, EKS, EC2, Load Balancer, and container deployment.
   - **variables.tf**: Define input variables (e.g., region, cluster name, environment name, instance types).
   - **outputs.tf**: Output values like the EKS cluster endpoint and Load Balancer URL.
   - **provider.tf**: Configuration to initialize the AWS provider for Terraform.
   - **modules**: Utilize Terraform modules for EKS, VPC, EC2, and Load Balancer.

2. **Create VPC**:  
   - Define a VPC with subnets, route tables, security groups, and other networking essentials.

3. **Create EKS Cluster**:  
   - Use the EKS module to create a Kubernetes cluster.
   - Set up worker nodes (EC2 instances) that will join the cluster.

4. **Deploy a Container**:  
   - Use Kubernetes manifest files to deploy a simple web application container on EKS (e.g., using a basic Nginx or Apache container).

5. **Set up Load Balancer**:  
   - Create an AWS ALB (Application Load Balancer) to expose the web interface of the container to the outside world.

6. **Test Deployment**:  
   - Ensure that the infrastructure is being provisioned correctly by running `terraform apply` multiple times to confirm that multiple environments can be created.

7. **Document the Process**:  
   - Write a detailed README file with all steps for setting up and deploying the infrastructure.

8. **Push to GitHub**:  
   - After completing the Terraform configuration and documentation, push everything to a public Git repository.

### Example Directory Structure

```
terraform-aws-eks-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── README.md
└── modules/
    ├── vpc/
    ├── eks/
    ├── ec2/
    └── load_balancer/
```

#### Helpful Terraform Modules
- **VPC**: [Terraform AWS VPC Module](https://github.com/terraform-aws-modules/terraform-aws-vpc)
- **EKS**: [Terraform AWS EKS Module](https://github.com/terraform-aws-modules/terraform-aws-eks)
- **EC2**: [Terraform AWS EC2 Module](https://github.com/terraform-aws-modules/terraform-aws-ec2)
- **ALB (Load Balancer)**: [Terraform AWS ALB Module](https://github.com/terraform-aws-modules/terraform-aws-alb)

- git clone https://github.com/yourusername/terraform-eks-project.git
cd terraform-eks-project

# Update terraform.tfvars for your env (e.g., name = "dev")
terraform init
terraform apply

# Terraform EKS Project

This Terraform project provisions a full EKS environment on AWS including:
- VPC (with public and private subnets)
- EKS Cluster
- EC2 Worker Nodes via managed node group
- NGINX container running in Kubernetes
- LoadBalancer exposing the web container

## Prerequisites
- AWS Account
- [Terraform](https://www.terraform.io/downloads) >= 1.3.3
- AWS CLI configured with credentials
- kubectl installed
- IAM user/role with permission to provision infrastructure

---

## 🔧 Usage

### 1. Clone the repository
```bash
git clone https://github.com/yourusername/terraform-eks-project.git
cd terraform-eks-project
```

### 2. Update Terraform variables
Edit or create a `terraform.tfvars` file with the following content:
```hcl
name   = "dev"
region = "us-east-1"
```

### 3. Configure backend (optional)
Edit `backend.tf` to point to your S3 bucket for state storage.

### 4. Initialize Terraform
```bash
terraform init
```

### 5. Apply the configuration
```bash
terraform apply
```

### 6. Get the LoadBalancer URL
```bash
echo $(terraform output -raw web_url)
```

---

## 📁 Files Overview
- `main.tf`: Main infrastructure resources
- `variables.tf`: Input variables
- `outputs.tf`: Outputs to display post-deploy
- `backend.tf`: Remote backend configuration (S3)
- `terraform.tfvars`: Sample environment-specific configuration

---

## 📦 Resources Used
- [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws)
- [terraform-aws-modules/eks/aws](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws)
- Kubernetes provider for deployments

---

## 🔁 Multiple Environments
To deploy multiple environments, just use different `name` values and S3 `key` paths in `backend.tf`:
```hcl
key = "eks/dev/terraform.tfstate" # for dev
to
key = "eks/prod/terraform.tfstate" # for prod
```

You can also deploy in parallel by using separate Terraform workspaces or folders.

---

## ⚠️ Clean Up
```bash
terraform destroy
```
This will remove all resources created.

---

## 📌 Notes
- This setup uses EKS managed node groups. If you want unmanaged EC2 worker nodes, we can add a separate module.
- You may need to update your kubeconfig:
```bash
aws eks update-kubeconfig --region us-east-1 --name dev-cluster
```

---

## 🤝 Support
If you're not familiar with AWS, DevOps, or IaC, just follow the steps above carefully. The README is designed to be beginner-friendly!

---

## Terraform Code Below

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

variable "region" {
  default = "us-east-1"
}

variable "name" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "web_url" {
  value = kubernetes_service.web.status[0].load_balancer[0].ingress[0].hostname
}
