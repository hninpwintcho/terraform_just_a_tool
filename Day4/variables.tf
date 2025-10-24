variable "hpc_vpc" {
  type = object({
    Name = string
    cidr = string
  })

  default = {
    Name = "VPC-A"
    cidr = "10.0.0.0/16"
  }
}




#### Creat of  lists of objects
# variable "public_subnets" {
#   type = list(object({
#     cidr = string
#     zone = string
#     Name = string
#   }))

#   default = [
#     {
#       cidr = "10.0.1.0/24"
#       zone = "ap-southeast-7a"
#       Name = "Public-Subnet-1"
#     },
#     { cidr = "10.0.2.0/24"
#       zone = "ap-southeast-7b"
#       Name = "Public-Subnet-2"
#     },
#     { cidr = "10.0.3.0/24"
#       zone = "ap-southeast-7c"
#       Name = "Public-Subnet-3"
#     }

#   ]


# }
#### Creat of  lists of objects

#### Creat of map of object  --> key 
variable "public_subnets" {
  type = map(object({
    cidr = string
    zone = string
    Name = string
  }))

  default = {
    "public_subnet_1" = {
      cidr = "10.0.1.0/24"
      zone = "ap-southeast-7a"
      Name = "Public-Subnet-1"
    },
    "public_subnet_2" = {
      cidr = "10.0.2.0/24"
      zone = "ap-southeast-7b"
      Name = "Public-Subnet-2"
    },
    "public_subnet_3" = {
      cidr = "10.0.3.0/24"
      zone = "ap-southeast-7c"
      Name = "Public-Subnet-3"
    }
  }
}
#### Creat of  lists of map --> key 


locals {
  vpc_name = aws_vpc.hpc_vpc.tags.Name
}

#### Create map string loop example 
# variable "love_letter" {
#   type = map(string)
#   default = {
#     "myanmar"  = "chit_tal"
#     "english"  = "I_Love_you"
#     "chinese"  = "wo_ai_ni"
#     "japanese" = "A_I_shite_Ru"
#   }
# }

# resource "local_file" "love_letter" {
#   filename = "./yeesarrsar.txt"
#   content  = var.love_letter["japanese"]
# }

# output "love_contenct" {
#     value = local_file.love_letter.content
# }
#### Create map string loop example
#each.key --> myanmar , english , chinese  ----Looping 
#each.vlaue --> chit_tal , I_love_you, Wo_ai_Ni 