output "alb_dns_name" {
  description = "Nom DNS de l’ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN du target group associé"
  value       = aws_lb_target_group.app.arn
}

output "listener_https_arn" {
  description = "ARN du listener HTTPS"
  value       = aws_lb_listener.https.arn
}

output "waf_arn" {
  description = "ARN de la Web ACL WAF associée"
  value       = aws_wafv2_web_acl.this.arn
}

output "alb_arn" {
  description = "ARN complet de l'ALB"
  value       = aws_lb.this.arn
}

output "alb_zone_id" {
  description = "Zone ID de l’ALB, utile pour Route53 alias"
  value       = aws_lb.this.zone_id
}
