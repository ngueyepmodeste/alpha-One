variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "Liste des subnets publics pour l'ALB"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste des Security Groups à attacher à l’ALB"
  type        = list(string)
}

variable "acm_cert_arn" {
  description = "ARN du certificat TLS ACM"
  type        = string
}

variable "environment" {
  description = "Environnement (dev, prod, etc.)"
  type        = string
}
