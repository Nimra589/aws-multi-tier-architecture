# AWS Multi-Tier Architecture (Terraform)

This repository provisions a secure and scalable AWS multi-tier architecture:
- Custom VPC with public and private subnets.
- Application Load Balancer (ALB) for high availability.
- EC2 web servers in public subnets.
- RDS MySQL database in private subnets.
- Security groups enforcing least privilege.

## Usage:
1. Update `variables.tf` with your AWS region, EC2 key, and DB credentials.
2. Run:
```bash
terraform init
terraform apply
