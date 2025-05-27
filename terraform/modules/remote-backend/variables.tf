variable "bucket_name" {
  description = "Nom du bucket S3 à utiliser comme remote backend"
  type        = string
}

variable "environment" {
  description = "Environnement (ex: dev, staging, prod)"
  type        = string
  default     = "dev"
}
