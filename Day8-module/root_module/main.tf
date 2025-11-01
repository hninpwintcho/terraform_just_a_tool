module "vpcA" {
  source         = "../modules/base_infra"
  project_name   = "vpca"
  vpc_cidr       = "10.0.0.0/16"
  subnet_cidr    = "10.0.1.0/24"
  az             = "ap-southeast-7a"
  ami_id         = var.ami_id
  instance_type  = "t3.micro"
}

module "vpcB" {
  source         = "../modules/base_infra"
  project_name   = "vpcb"
  vpc_cidr       = "172.16.0.0/16"
  subnet_cidr    = "172.16.1.0/24"
  az             = "ap-southeast-7b"
  ami_id         = var.ami_id
  instance_type  = "t3.micro"
}

resource "aws_vpc_peering_connection" "peer" {
  vpc_id      = module.vpcA.vpc_id
  peer_vpc_id = module.vpcB.vpc_id
  auto_accept = true

  tags = {
    Name = "vpca-to-vpcb-peer"
  }
}

# Add routes in both VPCs
resource "aws_route" "vpcA_to_vpcB" {
  route_table_id         = module.vpcA.route_table_id
  destination_cidr_block = "172.16.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "vpcB_to_vpcA" {
  route_table_id         = module.vpcB.route_table_id
  destination_cidr_block = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
