resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.env_prefix}-rds-subnet-group"
  description = "Subnet group for RDS in ${var.env_prefix}"
  subnet_ids  = var.public_subnet_ids

  tags = {
    Name = "${var.env_prefix}-rds-subnet-group"
  }
}

data "aws_rds_engine_version" "latest_postgres" {
  engine  = "postgres"
  # Optional: specify a major version to lock within a range (like all 15.x versions)
  # major_engine_version = "15"
}


resource "aws_db_instance" "this" {
  identifier        = "${var.env_prefix}-rds-postgres"
  engine            = "postgres"
  engine_version    = data.aws_rds_engine_version.latest_postgres.version  # Use latest!

  instance_class    = var.rds_instance_class
  allocated_storage = var.allocated_storage

  db_name           = "iesb"
  username          = "iesb"
  password          = var.rds_password

  publicly_accessible = true
  skip_final_snapshot = true

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name        = "${var.env_prefix}-rds-postgres"
    Environment = var.env_prefix
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.env_prefix}-rds-sg"
  description = "Allow access to RDS from within the VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]  # <-- This replaces the SG reference
    description = "Allow traffic from private subnet range"
  }

  tags = {
    Name        = "${var.env_prefix}-rds-sg"
    Environment = var.env_prefix
  }
}

