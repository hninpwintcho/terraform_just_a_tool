# Declare the date source
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

# create vpc
resource "aws_vpc" "hpc_vpc" {
  cidr_block = var.hpc_vpc.cidr
  tags = {
    Name = var.hpc_vpc.Name
  }
}

# create igw
resource "aws_internet_gateway" "hpc_vpc" {
  vpc_id = aws_vpc.hpc_vpc.id
  tags = {
    Name = "MY IGW" //VPC-A-IGW
  }
}
##Create nat_gateway
resource "aws_nat_gateway" "my_natgw" {
  allocation_id = aws_eip.my_natgw_eip.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_2"].id

  tags = {
    Name = "MY NAT GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.hpc_vpc]
}

resource "aws_eip" "my_natgw_eip" {
  domain = "vpc"
}

####  Create subnets for_each loop 
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets // map of object -->3 loop
  vpc_id                  = aws_vpc.hpc_vpc.id
  cidr_block              = each.value.cidr //10.0.1.0/24loop 
  map_public_ip_on_launch = true
  availability_zone       = each.value.zone //ap-southeast-7a loop
  tags = {
    Name = "${local.vpc_name}-${each.value.Name}" //VPC-A-Public-Subnet-1 loop
  }
}
####  Create for_each loop


#### Create subnet for count loop
# resource "aws_subnet" "public_subnets" {
# count = length(var.public_subnets) // list of 3 subnet objects 

# vpc_id                  = aws_vpc.hpc_vpc.id
# cidr_block              = var.public_subnets[count.index].cidr //10.0.1.0/24loop 
# map_public_ip_on_launch = true
# availability_zone       = var.public_subnets[count.index].zone //ap-southeast-7a loop
# tags = {
#  Name = "${local.vpc_name}-${var.public_subnets[count.index].Name}" //VPC-A-Public-Subnet-1 loop
# }
# }
#### Create count loop

# Create route table 
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.hpc_vpc.id
  tags = {
    Name = "${local.vpc_name}-Public_RTB"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hpc_vpc.id
  }
}

resource "aws_route_table_association" "public_rtb_association" {
  for_each       = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_rtb.id
  subnet_id      = each.value.id
}

