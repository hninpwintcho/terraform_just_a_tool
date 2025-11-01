output "vpcA_vpc_id" {
  value = module.vpcA.vpc_id
}

output "vpcB_vpc_id" {
  value = module.vpcB.vpc_id
}

output "vpcA_instance_public_ip" {
  value = module.vpcA.instance_public_ip
}

output "vpcB_instance_public_ip" {
  value = module.vpcB.instance_public_ip
}

output "vpc_peering_id" {
  value = aws_vpc_peering_connection.peer.id
}
