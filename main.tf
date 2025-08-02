provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  aws_region = var.aws_region
}

module "ec2" {
  source            = "./modules/ec2"
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  key_name          = var.key_name
}

module "rds" {
  source             = "./modules/rds"
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id             = module.vpc.vpc_id
  db_username        = var.db_username
  db_password        = var.db_password
  ec2_sg_id          = module.ec2.sg_id
}
