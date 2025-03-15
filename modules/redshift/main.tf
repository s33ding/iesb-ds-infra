resource "aws_security_group" "redshift_sg" {
  vpc_id = var.vpc_id
  name   = "${var.env_prefix}-redshift-sg"

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 🔴 Adjust this for security (avoid opening to all)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-redshift-sg"
  }
}

data "aws_secretsmanager_secret_version" "redshift_secret" {
  secret_id = "redshift-secret"
}

locals {
  redshift_creds = jsondecode(data.aws_secretsmanager_secret_version.redshift_secret.secret_string)
}

resource "aws_redshift_cluster" "redshift" {
  cluster_identifier        = "${var.env_prefix}-redshift"
  database_name             = local.redshift_creds["db_name"]
  master_username           = local.redshift_creds["username"]
  master_password           = local.redshift_creds["password"]
  node_type           = "dc2.large"
  cluster_type        = "single-node"

  publicly_accessible       = true
  skip_final_snapshot       = true
  vpc_security_group_ids    = [aws_security_group.redshift_sg.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.name

  tags = {
    Name = "${var.env_prefix}-redshift"
  }
}

# Select unique AZ subnets dynamically
locals {
  unique_az_subnets = distinct([
    for subnet in var.public_subnet_ids : subnet
    if length([
      for s in var.public_subnet_ids : s
      if s != subnet && var.subnet_az_map[s] != var.subnet_az_map[subnet]
    ]) > 0
  ])
}

# Create Redshift Subnet Group
resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name       = "${var.env_prefix}-redshift-subnet-group"
  subnet_ids = slice(local.unique_az_subnets, 0, 2) # Select 2 subnets in different AZs

  tags = {
    Name = "${var.env_prefix}-redshift-subnet-group"
  }
}

