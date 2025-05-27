variable "domain_name" {
  description = "Nom de domaine racine (ex: share-pictures.com)"
  type        = string
}

variable "record_name" {
  description = "Nom de l'enregistrement DNS (ex: www)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name de l'ALB cible"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID de l'ALB"
  type        = string
}

variable "environment" {
  description = "Environnement (ex: dev, prod)"
  type        = string
}
