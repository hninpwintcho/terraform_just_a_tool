

# Elastic IP
resource "aws_eip" "server_eip" {
  domain = "vpc"

  tags = merge(local.common_tags, {
    Name = local.eip_name
  })
}