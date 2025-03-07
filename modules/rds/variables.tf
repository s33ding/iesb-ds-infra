variable "env_prefix" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "additional_security_groups" {
  description = "Extra security groups to attach to RDS (e.g., webserver, redshift)"
  type        = list(string)
  default     = []
}

variable "vpc_cidr" {
  description = "The VPC CIDR block to allow inbound traffic from"
  type        = string
}

