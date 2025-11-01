output "instance_public_ip" {
  value       = aws_eip.server_eip.public_ip
  description = "Elastic IP of the EC2 instance"
}

output "ssh_command" {
  description = "SSH command to connect to EC2"
  value       = "ssh -i ${local_file.private_key.filename} ${local.user_name}@${aws_eip.server_eip.public_ip}"
}

output "workspace" {
  value = terraform.workspace
}
