# Networking
#vpc_cidr        = "10.1.0.0/16"
#subnet_cidr     = "10.1.1.0/24"

# Naming
vpc_Name         = "Stag-VPC"
subnet_Name      = "Stag_Public_Subnet"

# EC2 Instance
instance_type    = "t3.micro"
Operation_System = "ubuntu"
public_key_name  = "stag.pub"
private_key      = "stag.key"
instance_Name    = "Stag_Server"

# Security Group
sg_description   = "stag-SG"
sg_tag           = "stag_sg"

# Internet Gateway / Route / Elastic IP
igw_name         = "Stag-IGW"
rtp_Name         = "Stag-RT"
eip_name         = "Stag-EIP"
