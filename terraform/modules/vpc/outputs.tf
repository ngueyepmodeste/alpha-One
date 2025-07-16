####################################
# VPC A
####################################
output "vpc_a_id" {
  value = aws_vpc.vpc_a.id
}

output "vpc_a_public_subnet_id" {
  value = aws_subnet.public_subnet_a.id
}

output "vpc_a_private_subnet_id" {
  value = aws_subnet.private_subnet_a.id
}

output "vpc_a_nat_gateway_id" {
  value = aws_nat_gateway.nat_gw_a.id
}

output "vpc_a_igw_id" {
  value = aws_internet_gateway.igw_a.id
}

output "vpc_a_route_table_id" {
  value = aws_route_table.rt_private_a.id
}

####################################
# VPC B
####################################
output "vpc_b_id" {
  value = aws_vpc.vpc_b.id
}
output "vpc_b_public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_b1.id,
    aws_subnet.public_subnet_b2.id
  ]
}

output "vpc_b_private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_b1.id,
    aws_subnet.private_subnet_b2.id
  ]
}

output "vpc_b_igw_id" {
  value = aws_internet_gateway.igw_b.id
}

output "vpc_b_route_table_id" {
  value = aws_route_table.rt_private_b.id
}
