output "zone_id" {
  description = "ID de la zone DNS Route53"
  value       = aws_route53_zone.this.zone_id
}

output "record_name" {
  description = "Nom de l’enregistrement DNS"
  value       = aws_route53_record.app.name
}

output "record_fqdn" {
  description = "FQDN complet configuré pour l’application"
  value       = "${aws_route53_record.app.name}.${aws_route53_zone.this.name}"
}
