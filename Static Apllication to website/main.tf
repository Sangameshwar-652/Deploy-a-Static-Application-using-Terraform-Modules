provider "aws" {
  region = "us-east-1"  # Adjust the region as per your requirements
}

# Call VPC module
module "vpc" {
  source = "./modules/vpc-modules"
}

# Call Security module
module "security" {
  source = "./modules/security-modules"
  vpc_id = [module.vpc.vpc_id]
}

# Call EC2 module
module "ec2" {
  source          = "./modules/ec2-modules"
  vpc_id          = [module.vpc.vpc_id]
  security_group  = [module.security.security_group_id]
  ami_id          = "ami-12345678"  # Replace with a valid Amazon Linux AMI ID
  instance_type   = "t2.micro"
}