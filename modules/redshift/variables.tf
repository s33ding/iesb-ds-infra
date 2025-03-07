variable "env_prefix" {}
variable "redshift_password" {}
variable "public_subnet_ids" {
  type = list(string)
}

variable "additional_security_groups" {
  description = "List of additional security groups to allow inbound access to Redshift"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "VPC ID where the Redshift cluster is deployed"
  type        = string
}

