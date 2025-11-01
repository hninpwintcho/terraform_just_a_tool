output "ssh-command" {
  value = "ssh -i ${local_file.private-key.filename} ${local.user_name}@${aws_eip.server_eip.public_ip}"
}