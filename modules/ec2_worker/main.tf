resource "aws_iam_role" "eks_worker_role" {
  name = "${var.name}-worker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_attachments" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  ])
  role       = aws_iam_role.eks_worker_role.name
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "eks_worker_profile" {
  name = "${var.name}-worker-profile"
  role = aws_iam_role.eks_worker_role.name
}

data "aws_ami" "eks_worker_ami" {
  most_recent = true
  owners      = ["602401143452"] # EKS AMI owner

  filter {
    name   = "name"
    values = ["amazon-eks-node-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "eks_worker" {
  ami                    = data.aws_ami.eks_worker_ami.id
  instance_type          = "t3.medium"
  subnet_id              = element(var.private_subnets, 0)
  vpc_security_group_ids = [var.worker_security_group_id]
  key_name               = var.key_name

  iam_instance_profile = aws_iam_instance_profile.eks_worker_profile.name

  user_data = base64encode(templatefile("${path.module}/bootstrap.sh.tpl", {
    cluster_name = var.cluster_name
  }))

  tags = {
    Name = "${var.name}-eks-worker"
  }
}

