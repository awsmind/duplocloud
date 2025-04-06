# modules/app/outputs.tf
output "load_balancer_dns" {
  value = kubernetes_service.web.status[0].load_balancer[0].ingress[0].hostname
}
