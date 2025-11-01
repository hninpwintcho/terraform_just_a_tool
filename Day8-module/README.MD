Project Title

VPC Peering Connectivity Demo – Server A (VPCA) ↔ Server B (VPCB)
# Objective

Deploy two separate VPCs using Terraform (vpcA and vpcB).
Launch one EC2 instance in each VPC.
Create a VPC Peering Connection between both VPCs.
Enable connectivity so that Server A (VPC-A) can ping Server B (VPC-B).

# Deployment Steps
cd root_module
terraform init
terraform plan
terraform apply -auto-approve

# After apply:
Get both public IPs:
terraform output
