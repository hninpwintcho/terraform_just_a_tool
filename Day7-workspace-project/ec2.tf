# Key Pair
resource "tls_private_key" "prodKey" {
  algorithm = "RSA"
  rsa_bits  = 1024
}

resource "local_file" "private_key" {
  filename        = "${path.root}/${var.private_key}"
  content         = tls_private_key.prodKey.private_key_pem
  file_permission = "600"
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = local.key_name
  public_key = tls_private_key.prodKey.public_key_openssh
}

# Security Group
resource "aws_security_group" "server_sg" {
  vpc_id = aws_vpc.hpc_vpc.id
  name   = local.sg_name

  tags = merge(local.common_tags, {
    Name = local.sg_name
  })
}

resource "aws_vpc_security_group_ingress_rule" "ingress_all_allow" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "egress_all_allow" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}



# EC2 Instance
resource "aws_instance" "Server" {
  ami                    = local.selected_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key_pair.key_name
  subnet_id              = aws_subnet.public_subnets.id
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tags = merge(local.common_tags, {
    Name = local.instance_name
  })
}

# Associate EIP with EC2
resource "aws_eip_association" "allocation_to_ec2" {
  allocation_id = aws_eip.server_eip.id
  instance_id   = aws_instance.Server.id
}
