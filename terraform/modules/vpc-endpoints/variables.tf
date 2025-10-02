variable "region" {}

# VPC A
variable "vpc_a_id" {}
variable "vpc_a_private_subnets" {
  type = list(string)
}
variable "vpc_a_route_table_id" {}
variable "vpc_a_endpoint_sg_id" {
  type        = list(string)
}

# VPC B
variable "vpc_b_id" {}
variable "vpc_b_route_table_id" {}

# Buckets
variable "vault_backend_bucket_arn" {}
variable "uploads_bucket_arn" {}
