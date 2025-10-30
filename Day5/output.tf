output "my_zone" {
  value = data.aws_availability_zones.available.names
}

// "My VPC id is ---"
output "name" {
  value = "My VPC id is ${aws_vpc.hpc_vpc.id}." // Interpolation 
}