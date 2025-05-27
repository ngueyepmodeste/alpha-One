output "cert_arn" {
  value       = aws_acm_certificate.this.arn
  description = "ARN du certificat TLS ACM"
}
