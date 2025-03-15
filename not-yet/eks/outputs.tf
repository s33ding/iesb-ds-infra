output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}

