output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3_gateway_vpc_b.id
}

output "cloudwatch_logs_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.cloudwatch"].id
}

output "kms_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.kms"].id
}

output "sts_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.sts"].id
}

output "ec2_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.ec2"].id
}

output "ssm_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.ssm"].id
}

output "ssmmessages_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.ssmmessages"].id
}

output "secretsmanager_endpoint_id" {
  value = aws_vpc_endpoint.interface_endpoints_vpc_a["com.amazonaws.${var.region}.secretsmanager"].id
}
