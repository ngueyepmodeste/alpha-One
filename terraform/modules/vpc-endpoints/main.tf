locals {
  interface_endpoints = [
    "com.amazonaws.${var.region}.cloudwatch",
    "com.amazonaws.${var.region}.kms",
    "com.amazonaws.${var.region}.sts",
    "com.amazonaws.${var.region}.ec2",
    "com.amazonaws.${var.region}.ssm",
    "com.amazonaws.${var.region}.ssmmessages",
    "com.amazonaws.${var.region}.secretsmanager"
  ]
}

### VPC A ENDPOINTS

# Gateway Endpoint to access S3 from Vault
resource "aws_vpc_endpoint" "s3_gateway_vpc_a" {
  vpc_id            = var.vpc_a_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.vpc_a_route_table_id]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = ["s3:*"]
      Resource = [
        "${var.vault_backend_bucket_arn}",
        "${var.vault_backend_bucket_arn}/*"
      ]
    }]
  })

  tags = {
    Name = "s3-vault-endpoint-vpc-a"
  }
}

# Interface Endpoints for Vault
resource "aws_vpc_endpoint" "interface_endpoints_vpc_a" {
  for_each = toset(local.interface_endpoints)

  vpc_id             = var.vpc_a_id
  service_name       = each.value
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.vpc_a_private_subnets
  security_group_ids = var.vpc_a_endpoint_sg_id
  private_dns_enabled = true

  tags = {
    Name = "interface-${each.key}-vpc-a"
  }
}


### VPC B ENDPOINT

# Gateway Endpoint for S3 uploads from app
resource "aws_vpc_endpoint" "s3_gateway_vpc_b" {
  vpc_id            = var.vpc_b_id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [var.vpc_b_route_table_id]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = "*"
      Action = ["s3:*"]
      Resource = [
        "${var.uploads_bucket_arn}",
        "${var.uploads_bucket_arn}/*"
      ]
    }]
  })

  tags = {
    Name = "s3-uploads-endpoint-vpc-b"
  }
}
