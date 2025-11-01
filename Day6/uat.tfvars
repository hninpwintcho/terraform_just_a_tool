# Networking
#vpc_cidr        = "10.2.0.0/16"
#subnet_cidr     = "10.2.1.0/24"

# Naming
vpc_Name        = "UAT-VPC"
subnet_Name     = "UAT_Public_Subnet"

# EC2 Instance
instance_type    = "t3.micro"
Operation_System = "ubuntu"
public_key_name  = "uat.pub"
private_key      = "uat.key"
instance_Name    = "UAT-Server"

# Security Group
sg_description   = "UAT-SG"
sg_tag           = "uat_sg"

# Internet Gateway / Route / Elastic IP
igw_name         = "UAT-IGW"
rtp_Name         = "UAT-RT"
eip_name         = "UAT-EIP"
