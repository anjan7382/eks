############################################
# 1️⃣ EKS CONTROL PLANE IAM ROLE
############################################
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  # 👇 WHO CAN ASSUME THIS ROLE?
  # Only the EKS service (NOT EC2)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Required policy for EKS control plane
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

############################################
# 2️⃣ WORKER NODE (EC2) IAM ROLE
############################################
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  # 👇 WHO CAN ASSUME THIS ROLE?
  # Only EC2 instances (worker nodes)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Worker node permissions (MANDATORY)
resource "aws_iam_role_policy_attachment" "node_worker_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "node_ecr_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

#iam.tf — ONLY CREATES PERMISSIONS
#Creates IAM roles and policies
#Does NOT create EKS
#Does NOT create EC2
#Does NOT run pods
#👉 IAM = who is allowed to do what
