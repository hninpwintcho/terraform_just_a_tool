variable "vpc_cidr" {

}
variable "vpc_Name" {

}
variable "subnet_cidr" {

}
variable "subnet_Name" {

}
variable "instance_type" {

}
variable "public_key_name" {

}
variable "private_key" {

}
variable "instance_Name" {

}

variable "sg_description" {

}
variable "sg_tag" {

}
variable "igw_name" {

}
variable "rtp_Name" {

}
variable "eip_name" {

}
variable "Operation_System" {
  description = "Choose your OS: [ \"ubuntu\" , \"amazon-linux-2\" , \"redhat\"]"
  validation {
    condition     = var.Operation_System == "ubuntu" || var.Operation_System == "amazon-linux-2" || var.Operation_System == "redhat"
    error_message = "Choose correct Operation System"
  }
}