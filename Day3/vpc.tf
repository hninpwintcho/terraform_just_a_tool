
data "aws_availability_zones" "available" {
    state = "available"
    
}
//VPC
resource "aws_vpc" "Loveline" {
 cidr_block = var.my_vpc_cidr
 tags = {
     Name= var.my_vpc_name
 } 
}
//MY IGW
resource "aws_internet_gateway" "myigw" {
    tags = {
        Name = "MY_IGW"
    }
  
}
// attached IGW to VPC
resource "aws_internet_gateway_attachment" "igw_vpc" {
    internet_gateway_id = aws_internet_gateway.myigw.id
    vpc_id = aws_vpc.Loveline.id
  
}
//Public Route table 
resource "aws_route_table" "my_public_rtb" {
    vpc_id = aws_vpc.Loveline.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myigw.id
    }

    tags = {
      Name="My public route Table"
    } 
}

// Private Route table 
resource "aws_route_table" "my_private_rtb" {
    vpc_id = aws_vpc.Loveline.id

    tags = {
        Name = "My private route Table"
    }
}

//Subnets
resource "aws_subnet" "mypublicsubnets" {
    count = length(data.aws_availability_zones.available.names)
    vpc_id = aws_vpc.Loveline.id
    availability_zone = var.zone_for_subnets[count.index]
    cidr_block = var.public_subnet_cidrs[count.index]
    tags = {
      Name= var.public_subnet_names[count.index]
    }
}

resource "aws_route_table_association" "pub_rtb_subnets" {
    count = length(aws_subnet.mypublicsubnets)
    route_table_id = aws_route_table.my_public_rtb.id
    subnet_id = aws_subnet.mypublicsubnets[count.index].id
  
}

resource "aws_subnet" "myprivatesubnets" {
    count = length(data.aws_availability_zones.available.names)
    vpc_id = aws_vpc.Loveline.id
    availability_zone = var.zone_for_subnets[count.index]
    cidr_block = var.private_subnet_cidrs[count.index]
    tags = {
      Name= var.private_subnet_names[count.index]
    }
}

resource "aws_route_table_association" "pri_rtb_subnets" {
    count = length(aws_subnet.myprivatesubnets)
    route_table_id = aws_route_table.my_private_rtb.id
    subnet_id = aws_subnet.myprivatesubnets[count.index].id
  
}


