# modules/eks/variables.tf
variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}

variable "environment" {
  type = string
}
