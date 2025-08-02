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
3. Access your web app via the ALB DNS name in outputs.

---

### ✅ **How to Upload**
1. Create a GitHub repo named **`aws-multi-tier-architecture`**.
2. Clone it locally:
   ```bash
   git clone https://github.com/<your-username>/aws-multi-tier-architecture.git
3. Copy all the files/folders above into the cloned repo.
4. Push to GitHub:
cd aws-multi-tier-architecture
git add .
git commit -m "Initial commit - AWS Multi-Tier Architecture"
git push origin main

