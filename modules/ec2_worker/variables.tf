variable "name" {}
variable "cluster_name" {}
variable "key_name" {}
variable "private_subnets" {
  type = list(string)
}
variable "worker_security_group_id" {}

