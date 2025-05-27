variable "vpc_id" {
  description = "ID du VPC où les SG seront créés"
  type        = map(string)
}

variable "allowed_ssh_cidrs" {
  description = "Liste des IPs autorisées pour SSH"
  type        = list(string)
}

variable "allowed_internal_cidrs" {
  description = "CIDRs internes autorisés pour les composants sensibles"
  type        = list(string)
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
}

variable "environment" {
  description = "Environnement (e.g. dev, staging, prod)"
  type        = string
}

