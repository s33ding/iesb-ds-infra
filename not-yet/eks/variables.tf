variable "cluster_name" {}
variable "cluster_version" {}
variable "subnet_ids" { type = list(string) }
variable "vpc_id" {}
variable "node_group_desired_size" {}
variable "node_group_min_size" {}
variable "node_group_max_size" {}
variable "node_group_instance_types" { type = list(string) }

