terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-7"
  default_tags{
    tags = {
      "Managed_by" = "Terraform"
    }
  }

}
