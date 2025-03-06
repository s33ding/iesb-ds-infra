provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "${var.env_prefix}-vpc"
  cidr = var.vpc_cidr_block

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  tags = {
    Environment = var.env_prefix
  }
}


module "webserver" {
  source              = "./modules/webserver"
  vpc_id              = module.vpc.vpc_id
  my_ip                = var.my_ip
  env_prefix          = var.env_prefix
  image_name          = var.image_name
  public_key_location = var.public_key_location
  instance_type       = var.instance_type
  subnet_id           = module.vpc.public_subnets[0]
  avail_zone          = "us-east-1a"
}

module "redshift" {
  source            = "./modules/redshift"
  env_prefix        = var.env_prefix
  redshift_password = var.redshift_password
}

