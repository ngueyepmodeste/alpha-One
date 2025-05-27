variable "domain_name" {
  description = "Nom de domaine principal pour le certificat"
  type        = string
}

variable "san" {
  description = "Subject Alternative Names (SAN)"
  type        = list(string)
  default     = []
}

variable "hosted_zone_id" {
  description = "ID de la zone hébergée Route53"
  type        = string
}

variable "environment" {
  description = "Environnement (dev, prod)"
  type        = string
}
