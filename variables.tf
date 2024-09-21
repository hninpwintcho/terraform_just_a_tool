variable "my_vpc_name" {
    default = "Day-3_assignment"
    
}
variable "my_vpc_cidr" {
    default = "10.0.0.0/16"
  
}
variable "zone_for_subnets" {
    type = list(string)
    default = [ "ap-northeast-1a","ap-northeast-1c","ap-northeast-1d" ] 
}
variable "public_subnet_cidrs" {
    type = list(string)
    default = [ "10.0.11.0/24", "10.0.12.0/24","10.0.13.0/24" ]
}
variable "public_subnet_names" {
    type = list(string)
    default = [ "mypub_subnet1", "mypub_subnet2","mypub_subnet3" ]
}

variable "private_subnet_cidrs" {
  default = [ "10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24" ]
  type        = list(string)
}

variable "private_subnet_names" {
    type = list(string)
    default = [ "mypri_subnet1", "mypri_subnet2","mypri_subnet3" ]
}