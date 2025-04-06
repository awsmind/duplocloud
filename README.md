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

