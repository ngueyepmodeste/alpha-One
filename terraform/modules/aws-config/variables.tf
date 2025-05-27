variable "project_name" {
  type        = string
  description = "Nom du projet"
}

variable "environment" {
  type        = string
  description = "Nom de l'environnement"
}

variable "config_role_arn" {
  type        = string
  description = "ARN du rôle IAM utilisé par AWS Config"
}
