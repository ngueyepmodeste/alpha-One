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

variable "vpcA_id" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
}
variable "vpcB_id" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
}

variable "vpc_cidr_a" {
  description = "CIDR block pour le VPC A"
  type        = string
}

variable "vpc_cidr_b" {
  description = "CIDR block pour le VPC B"
  type        = string
}

variable "key_name" {
  description = "Nom de la clé SSH pour l’accès à la bastion"
  type        = string
}

variable "domain_name" {
  description = "Nom de domaine principal (ex: app.mondomaine.com)"
  type        = string
}
variable "env" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
  default     = "prod"
}
variable "alias"{
  description = "Alias de l'application (ex: app, api, db)"
  type        = string
  default =  "us_east_1"
}