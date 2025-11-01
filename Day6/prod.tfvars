# Networking
#vpc_cidr    = "10.0.0.0/16"
#subnet_cidr = "10.0.1.0/24"

# Naming
vpc_Name    = "Prod-VPC"
subnet_Name = "Prod_Public_Subnet"

# EC2 Instance
instance_type    = "t3.micro"
Operation_System = "ubuntu"
public_key_name  = "001.pub"
private_key      = "002.key"
instance_Name    = "Prod-Server"

# Security Group
sg_description = "Prod-SG"
sg_tag         = "prod_sg"

# Internet Gateway / Route / Elastic IP
igw_name = "Prod-IGW"
rtp_Name = "Prod-RT"
eip_name = "Prod-EIP"
