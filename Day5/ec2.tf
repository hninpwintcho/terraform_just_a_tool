resource "tls_private_key" "ssh_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  filename = "${path.root}/private_key.pem"
  content  = tls_private_key.ssh_keypair.private_key_pem
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "001.pub"
  public_key = tls_private_key.ssh_keypair.public_key_openssh
}
// private  //public key 


resource "aws_instance" "server" {
  ami                    = local.selected_ami
  subnet_id              = aws_subnet.public_subnets["public_subnet_1"].id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.server_sg.id]
  key_name               = aws_key_pair.ec2_key_pair.key_name

  tags = {
    Name = "${local.vpc_name}"
  }
}

resource "aws_eip" "public_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "binding_server_eip" {
  instance_id   = aws_instance.server.id
  allocation_id = aws_eip.public_eip.id
}

resource "aws_security_group" "server_sg" {
  vpc_id = aws_vpc.hpc_vpc.id
  name   = "server-sg"
  tags = {
    Name = "Server_SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ssh_allow" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = local.any_where
  from_port         = local.ssh
  ip_protocol       = "tcp"
  to_port           = local.ssh
}

resource "aws_vpc_security_group_egress_rule" "egress_all_allow" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = local.any_where
  ip_protocol       = local.any_protocol
}

# ubuntu , amazon-linux-2 , red-hat 

variable "Operation_System" {
  description = "Choose your OS: [ \"ubuntu\" , \"amazon-linux-2\" , \"red-hat\"]"
  validation {
    condition     = var.Operation_System == "ubuntu" || var.Operation_System == "amazon-linux-2" || var.Operation_System == "red-hat"
    error_message = "show error ,, show error "
  }

}

locals {

  ssh          = 22
  any_protocol = "-1"
  any_where    = "0.0.0.0/0"
  os_to_ami = {
    "ubuntu"         = "ami-0aa9ab10add089314"
    "amazon-linux-2" = "ami-0b9a325ab140afeee"
    "red-hat"        = "ami-0e15b600a09e9961a"
  }
  ssh_username = {
    "ami-0aa9ab10add089314" = "ubuntu"
    "ami-0b9a325ab140afeee" = "ec2-user"
  }

  selected_ami = lookup(local.os_to_ami, var.Operation_System, "whoami?")
}

// lookup( {"ubuntu"         = "ami-0aa9ab10add089314","amazon-linux-2" = "ami-0b9a325ab140afeee","red-hat" = "ami-0e15b600a09e9961a" })
output "ssh_command" {
  value = "ssh -i ${local_file.private_key.filename} ${lookup(local.ssh_username, local.selected_ami, "No Need")}@${aws_eip.public_eip.public_ip}" //"ssh -i ./private.pem ubuntu@publicIP"
}