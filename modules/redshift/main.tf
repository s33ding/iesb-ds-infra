resource "aws_redshift_cluster" "this" {
  cluster_identifier  = "${var.env_prefix}-test-redshift"
  database_name       = "iesb"
  master_username     = "iesb"
  master_password     = var.redshift_password

  node_type           = "dc2.large"  # Medium-size instance
  cluster_type        = "single-node"

  skip_final_snapshot = true

  tags = {
    Environment = var.env_prefix
    Purpose     = "Testing"
  }
}

