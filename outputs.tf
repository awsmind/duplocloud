output "vpc_id" {
  value = module.vpc.vpc_id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "web_url" {
  value = kubernetes_service.web.status[0].load_balancer[0].ingress[0].hostname
}
