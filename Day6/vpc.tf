resource "aws_vpc" "hpc_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_Name
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.hpc_vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id     = aws_vpc.hpc_vpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = var.subnet_Name
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.hpc_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = var.rtp_Name
  }
}

resource "aws_route_table_association" "public_rtb_association" {
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = aws_subnet.public_subnets.id
}