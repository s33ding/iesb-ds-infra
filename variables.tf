variable "env_prefix" {
  default = "dev"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "avail_zone" {
  default = "us-east-1a"
}

variable "my_ip" {
  default = "YOUR_IP_HERE/32"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "public_key_location" {
  default = "~/.ssh/id_rsa.pub"
}

variable "image_name" {
  default = "amazonlinux2"
}

variable "rds_password" {
  sensitive = true
}

variable "rds_instance_class" {
  default = "db.t3.micro"
}

variable "allocated_storage" {
  default = 20
}

variable "redshift_password" {
  sensitive = true
}

