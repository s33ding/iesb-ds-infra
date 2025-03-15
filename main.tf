module "vpc" {
  source = "./modules/vpc"

  env_prefix        = var.env_prefix
  vpc_cidr_block    = var.vpc_cidr_block
  availability_zones = var.availability_zones
  public_subnets    = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
}

module "rds" {
  source = "./modules/rds"
  env_prefix       = var.env_prefix
  vpc_id           = module.vpc.vpc_id
  public_subnets = var.public_subnets  # ✅ Change to Public Subnets
}

module "redshift" {
  source         = "./modules/redshift"
  env_prefix     = var.env_prefix
  vpc_id         = module.vpc.vpc_id
  public_subnets = var.public_subnets
  public_subnet_ids = var.public_subnet_ids
  subnet_az_map     = var.subnet_az_map
}

