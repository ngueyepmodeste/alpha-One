########################
# VPC A
########################

resource "aws_vpc" "vpc_a" {
  cidr_block           = var.vpc_a_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(local.common_tags, { Name = "vpc_a" })
}

resource "aws_internet_gateway" "igw_a" {
  vpc_id = aws_vpc.vpc_a.id
  tags   = merge(local.common_tags, { Name = "igw_a" })
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, { Name = "public-subnet-a" })
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false
  tags                    = merge(local.common_tags, { Name = "private-subnet-a" })
}

resource "aws_eip" "nat_eip_a" {
  domain = "vpc"
  tags   = merge(local.common_tags, { Name = "eip_nat_a" })
}

resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id = aws_eip.nat_eip_a.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags          = merge(local.common_tags, { Name = "nat_gw_a" })
}

resource "aws_route_table" "rt_public_a" {
  vpc_id = aws_vpc.vpc_a.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_a.id
  }
  tags = merge(local.common_tags, { Name = "rt_public_a" })
}

resource "aws_route_table_association" "assoc_public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.rt_public_a.id
}

resource "aws_route_table" "rt_private_a" {
  vpc_id = aws_vpc.vpc_a.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_a.id
  }
  tags = merge(local.common_tags, { Name = "rt_private_a" })
}

resource "aws_route_table_association" "assoc_private_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.rt_private_a.id
}

########################
# VPC B
########################

resource "aws_vpc" "vpc_b" {
  cidr_block           = var.vpc_b_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(local.common_tags, { Name = "vpc_b" })
}

resource "aws_internet_gateway" "igw_b" {
  vpc_id = aws_vpc.vpc_b.id
  tags   = merge(local.common_tags, { Name = "igw_b" })
}

resource "aws_subnet" "public_subnet_b1" {
  vpc_id                  = aws_vpc.vpc_b.id
  cidr_block              = var.public_subnet_b1_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, { Name = "public-subnet-b1" })
}
resource "aws_subnet" "public_subnet_b2" {
  vpc_id                  = aws_vpc.vpc_b.id
  cidr_block              = var.public_subnet_b2_cidr
  availability_zone       = var.az_d
  map_public_ip_on_launch = true
  tags                    = merge(local.common_tags, { Name = "public-subnet-b2" })
}

resource "aws_subnet" "private_subnet_b1" {
  vpc_id            = aws_vpc.vpc_b.id
  cidr_block        = var.private_subnet_b1_cidr
  availability_zone = var.az_b
  tags              = merge(local.common_tags, { Name = "private-subnet-b1" })
}

resource "aws_subnet" "private_subnet_b2" {
  vpc_id            = aws_vpc.vpc_b.id
  cidr_block        = var.private_subnet_b2_cidr
  availability_zone = var.az_c
  tags              = merge(local.common_tags, { Name = "private-subnet-b2" })
}

resource "aws_route_table" "rt_public_b" {
  vpc_id = aws_vpc.vpc_b.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_b.id
  }
  tags = merge(local.common_tags, { Name = "rt_public_b" })
}

resource "aws_eip" "nat_eip_b" {
  domain = "vpc"
  tags   = merge(local.common_tags, { Name = "eip_nat_b" })
}

resource "aws_nat_gateway" "nat_gw_b" {
  allocation_id = aws_eip.nat_eip_b.id
  subnet_id     = aws_subnet.public_subnet_b2.id
  tags          = merge(local.common_tags, { Name = "nat_gw_b" })
}

resource "aws_route_table" "rt_private_b" {
  vpc_id = aws_vpc.vpc_b.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_b.id
  }
  tags = merge(local.common_tags, { Name = "rt_private_b" })
}

resource "aws_route_table_association" "assoc_public_b" {
  subnet_id      = aws_subnet.public_subnet_b2.id
  route_table_id = aws_route_table.rt_public_b.id
}

resource "aws_route_table_association" "assoc_private_b1" {
  subnet_id      = aws_subnet.private_subnet_b1.id
  route_table_id = aws_route_table.rt_private_b.id
}

resource "aws_route_table_association" "assoc_private_b2" {
  subnet_id      = aws_subnet.private_subnet_b2.id
  route_table_id = aws_route_table.rt_private_b.id
}
