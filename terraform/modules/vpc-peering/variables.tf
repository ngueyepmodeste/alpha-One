variable "vpc_a_id" {
  description = "ID of VPC A (source)"
  type        = string
}

variable "vpc_b_id" {
  description = "ID of VPC B (peer)"
  type        = string
}

variable "vpc_a_cidr" {
  description = "CIDR block of VPC A"
  type        = string
}

variable "vpc_b_cidr" {
  description = "CIDR block of VPC B"
  type        = string
}

variable "vpc_a_route_table_id" {
  description = "Route table ID for VPC A"
  type        = string
}

variable "vpc_b_route_table_id" {
  description = "Route table ID for VPC B"
  type        = string
}
