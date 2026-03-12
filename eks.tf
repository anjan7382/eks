module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.control_plane_subnets

  addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  eks_managed_node_groups = {

    workers = {

      instance_types = [var.instance_type]
      ami_type       = "AL2023_x86_64_STANDARD"

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

    }

  }

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }

}


