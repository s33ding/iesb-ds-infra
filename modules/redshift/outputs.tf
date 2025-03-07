output "redshift_endpoint" {
  value = aws_redshift_cluster.this.endpoint
}

output "redshift_cluster_id" {
  value = aws_redshift_cluster.this.cluster_identifier
}

output "redshift_sg_id" {
  value = aws_security_group.redshift_sg.id
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC"
  type        = string
}

