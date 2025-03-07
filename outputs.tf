output "ec2-public_ip" {
  value = module.webserver.public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "redshift_endpoint" {
  value = module.redshift.redshift_endpoint
}

output "redshift_cluster_id" {
  value = module.redshift.redshift_cluster_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_instance_id" {
  value = module.rds.rds_instance_id
}

