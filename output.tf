output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "vpc_id" {
  value = aws_vpc.eks.id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}
