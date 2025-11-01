locals {
  common_tags = {
    "Managed by" = "Terraform"
  }
}

locals {
  ami = {
    "ubuntu"         = "ami-0aa9ab10add089314"
    "amazon-linux-2" = "ami-0b9a325ab140afeee"
    "redhat"         = "ami-0e15b600a09e9961a"
  }
  ssh_user = {
    "ami-0aa9ab10add089314" = "ubuntu"
    "ami-0b9a325ab140afeee" = "ec2-user"
    "ami-0e15b600a09e9961a" = "ec2-user"

  }
  selected_ami = lookup(local.ami, var.Operation_System)
  user_name    = lookup(local.ssh_user, local.selected_ami, "no need")
}