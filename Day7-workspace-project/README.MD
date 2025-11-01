Day6 --> Project: Terraform Multi-Workspace VPC Deployment

- Goal : Local backebd with three workspaces { UAT, Staging , Prod}
- One config folder (root module)--> three workspace
- Deploy the below architecture with respective value file (eg , uat.tfvars) in respective workspace.
- we will not use dafault workspace
- Input variables will be asked:
    - vpc_cidr
    - public_subnet_cidr
- Names mush be set based on current terraform workspace: (no input var)
    - VPC name -> ${terraform.workspace}-public-vpc
    - Key Pair name ->${terraform.workspace}-public-key
    - EC2 instance name ->${terraform.workspace}-instance
    - EC2 tags must include "Managed by " "Terraform" by referencing locals

    ![alt text](<ChatGPT Image Nov 1, 2025, 11_11_16 AM.png>)


How to Deploy Per Environment
# Create 3 workspaces
terraform workspace new uat
terraform workspace new staging
terraform workspace new prod

# Deploy each
terraform workspace select uat
terraform apply -var-file=uat.tfvars

terraform workspace select prod
terraform apply -var-file=prod.tfvars

terraform workspace select staging
terraform apply -var-file=staging.tfvars
# List all workspaces
terraform workspace list

# Destroy resources workspace by workspace
# Destroy UAT
terraform workspace select uat
terraform destroy -var-file=uat.tfvars

# Destroy Staging
terraform workspace select staging
terraform destroy -var-file=staging.tfvars

# Destroy Prod
terraform workspace select prod
terraform destroy -var-file=prod.tfvars


