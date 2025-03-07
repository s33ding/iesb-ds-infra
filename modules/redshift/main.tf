resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name        = "${var.env_prefix}-redshift-subnet-group"
  description = "Subnet group for Redshift"
  subnet_ids  = var.public_subnet_ids

  tags = {
    Name        = "${var.env_prefix}-redshift-subnet-group"
    Environment = var.env_prefix
  }
}

resource "aws_redshift_cluster" "this" {   # 👈 This is the missing piece!
  cluster_identifier  = "${var.env_prefix}-redshift-cluster"
  database_name       = "iesb"
  master_username     = "masteruser"
  master_password     = var.redshift_password

  node_type           = "dc2.large"
  cluster_type        = "single-node"

  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.redshift_sg.id]

  skip_final_snapshot = true

  tags = {
    Name        = "${var.env_prefix}-redshift-cluster"
    Environment = var.env_prefix
  }
}

resource "aws_security_group" "redshift_sg" {
  name        = "${var.env_prefix}-redshift-sg"
  description = "Allow access to Redshift from private subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Redshift traffic from private subnet"
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]  # 🔥 Again, no hard SG dependency
  }

  tags = {
    Name        = "${var.env_prefix}-redshift-sg"
    Environment = var.env_prefix
  }
}

