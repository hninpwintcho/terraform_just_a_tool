resource "aws_eip" "server_eip" {
  tags = {
    Name = var.eip_name
  }
}