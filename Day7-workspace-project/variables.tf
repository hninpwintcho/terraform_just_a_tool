# ========================
# Network Configuration
# ========================
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
}

# ========================
# EC2 Configuration
# ========================
variable "instance_type" {
  description = "Type of EC2 instance"
}

variable "Operation_System" {
  description = "Choose your OS: [\"ubuntu\", \"amazon-linux-2\", \"redhat\"]"
  validation {
    condition     = var.Operation_System == "ubuntu" || var.Operation_System == "amazon-linux-2" || var.Operation_System == "redhat"
    error_message = "Choose correct Operation System"
  }
}

# ========================
# Key Pair Configuration
# ========================
variable "public_key_name" {
  description = "Key name to register on AWS"
}

variable "private_key" {
  description = "Local private key filename (for SSH)"
}
