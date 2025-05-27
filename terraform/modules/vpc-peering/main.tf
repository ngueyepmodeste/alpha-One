resource "aws_vpc_peering_connection" "vpc_a_to_b" {
  vpc_id        = var.vpc_a_id
  peer_vpc_id   = var.vpc_b_id
  auto_accept   = true

  tags = {
    Name = "vpc-a-to-b"
  }
}

resource "aws_route" "route_a_to_b" {
  route_table_id         = var.vpc_a_route_table_id
  destination_cidr_block = var.vpc_b_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_b.id
}

resource "aws_route" "route_b_to_a" {
  route_table_id         = var.vpc_b_route_table_id
  destination_cidr_block = var.vpc_a_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_a_to_b.id
}
