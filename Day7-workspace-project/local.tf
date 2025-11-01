locals {
  # Common tag applied to all resources
  common_tags = {
    "Managed by" = "Terraform"
  }

  # OS AMIs
  ami = {
    "ubuntu"         = "ami-0aa9ab10add089314"
    "amazon-linux-2" = "ami-0b9a325ab140afeee"
    "redhat"         = "ami-0f6510f58ad5c93e3"
  }

  ssh_user = {
    "ami-0aa9ab10add089314" = "ubuntu"
    "ami-0b9a325ab140afeee" = "ec2-user"
    "ami-0f6510f58ad5c93e3" = "ec2-user"
  }

  selected_ami = lookup(local.ami, var.Operation_System)
  user_name    = lookup(local.ssh_user, local.selected_ami, "no need")

  # Workspace-based naming
  vpc_name         = "${terraform.workspace}-VPC"
  subnet_name      = "${terraform.workspace}_Public_Subnet"
  igw_name         = "${terraform.workspace}-IGW"
  rt_name          = "${terraform.workspace}-RT"
  sg_name          = "${terraform.workspace}-SG"
  instance_name    = "${terraform.workspace}-Server"
  key_name         = "${terraform.workspace}-key"
  eip_name         = "${terraform.workspace}-EIP"
}
