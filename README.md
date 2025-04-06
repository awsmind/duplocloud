# Duplocloud Interview Overview Notes
Items Completed:
Use Terraform => 1.3.3
Use publicly available Terraform Modules
Able to apply the Terraform project multiple times within a single AWS Region to create multiple environments
Terraform project must create the following resources
VPC, EKS, EC2 instance as EKS worker node, Any container running on EKS with a web interface, and Load balancer that exposes the web interface of the container

### Summary of the Terraform Interview Project for AWS

1. **Set up Terraform Configuration Files**:  
   - **main.tf**: Main configuration that includes the setup for VPC, EKS, EC2, Load Balancer, and container deployment.
   - **variables.tf**: Define input variables (e.g., region, cluster name, environment name, instance types).
   - **outputs.tf**: Output values like the EKS cluster endpoint and Load Balancer URL.
   - **provider.tf**: Configuration to initialize the AWS provider for Terraform.
   - **modules**: Utilize Terraform modules for EKS, VPC, EC2, and App.

2. **Set up Terraform Configuration Files**:  
   - This includees EKS, EC2_worker, and the VPC
3. **Create VPC**:  
   - Define a VPC with subnets, route tables, security groups, and other networking essentials.

4. **Create EKS Cluster**:  
   - Use the EKS module to create a Kubernetes cluster.
   - Set up worker nodes (EC2 instances) that will join the cluster.

5. **Deploy a Container**:  
   - Use Kubernetes manifest files to deploy a simple web application container on EKS (e.g., using a basic Nginx or Apache container).

### Directory Structure I Built

duplocloud/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── versions.tf
├── README.md
└── modules/
    ├── vpc/
    ├── eks/
    ├── ec2/
    └── app/
```

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

## Prerequisites for anyone installing this
- AWS Account
- [Terraform](https://www.terraform.io/downloads) >= 1.3.3
- AWS CLI configured with credentials
- kubectl installed
- IAM user/role with permission to provision infrastructure

---

## 🔧 Usage

### 1. Clone the repository
```bash
git clone https://github.com/awsmind/duplocloud.git
cd duplocloud
```

### 2. Update Terraform variables
Edit or create a `terraform.tfvars` file with the following content:
```hcl
name   = "dev"
region = "us-east-1"
```

### 3. Configure backend (optional)
Edit the bucket name in the main.tfto point to your S3 bucket for state storage.

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

## 📁 Understand Your New Files Overview from what I created
- `main.tf`: Main infrastructure resources
- `variables.tf`: Input variables
- `outputs.tf`: Outputs to display post-deploy
- `backend.tf`: Remote backend configuration (S3)
- `terraform.tfvars`: Sample environment-specific configuration
- 
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
- 1. This setup uses EKS managed node groups. If you want unmanaged EC2 worker nodes, we can add a separate module.
- You may need to update your kubeconfig:
```bash
aws eks update-kubeconfig --region us-east-1 --name dev-cluster
```
- 2. Check the output web_url for the external load balanced URL. The external hostname is output by Terraform:
output "web_url" {
  value = kubernetes_service.web.status[0].load_balancer[0].ingress[0].hostname
}
- 3. I would note also that if you're going for unmanaged EC2 worker nodes (instead of using EKS managed node groups), then your ec2_worker/main.tf should handle this. I added a module under EC2_worker for that. You would need to install the IAM Role and Instance Profile for EC2 worker, Lookup of the correct EKS-optimized AMI, Use the module to launch the EC2 instance in a private subnet, then use bootstrapping the node to join the EKS cluster
}

Another option would have been to add the AWS Load Balancer Controller, install HELM, Create an Ingress Resource, Exposes your NGINX container on port 80, which will output a public DNS name
