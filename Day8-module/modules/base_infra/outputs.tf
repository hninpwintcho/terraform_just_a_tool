output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_id" {
  value = aws_subnet.public.id
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}

output "route_table_id" {
  value = aws_route_table.public.id
}
