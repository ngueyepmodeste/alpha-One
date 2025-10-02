variable "aws_region" {
  type        = string
  description = "la region où notre architecture sera deployer"
  default     = "us-east-1"
}
variable "aws_profile" {
  type        = string
  description = "le profile AWS à utiliser"
  default     = "mon-profil-pro"
}
variable "project" {
  description = "Nom du projet (ex: infra-k8s)"
  type        = string
  default     = "alpha-one"
}
variable "env" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
  default     = "prod"
}
variable "alias" {
  description = "Alias de l'application (ex: app, api, db)"
  type        = string
  default     = "us_east_1"
}