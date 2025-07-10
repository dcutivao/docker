module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_az      = var.availability_az
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  security_groups = [
    {
      name        = "ec2-sg"
      description = "Security Group para EC2"
      ingress_rules = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
      ]
      egress_rules = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
      ]
    }
  ]
}

module "keys" {
  source      = "./modules/key"
  environment = var.environment
}

module "ec2" {
  source = "./modules/ec2"
  name_instance = var.name_instance

  aws_region         = var.aws_region
  amis               = var.amis
  environment        = var.environment
  output_private_key = module.keys.output_private_key
  instances = {
    (var.name_instance) = {
      instance_type   = "t2.micro"
      subnet_id       = module.vpc.public_subnets[0]
      os              = "ubuntu"
      key_name        = module.keys.aws_key_pair
      security_groups = [module.security_groups.security_group_ids["ec2-sg"]]
      #iam_instance_profile = module.iam.iam_instance_profiles["EC2Role"]
    }
  }
}