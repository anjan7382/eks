cluster_name       = "banking-eks"
kubernetes_version = "1.29"

vpc_id = "vpc-1234556abcdef"

private_subnets = [
  "subnet-abcde012",
  "subnet-bcde012a",
  "subnet-fghi345a"
]

control_plane_subnets = [       # private subnets for both worker nodes and eks cluster where vpc is already
                                  created by network teams
  "subnet-xyzde987",
  "subnet-slkjf456",
  "subnet-qeiru789"
]

instance_type = "t3.medium"
key_pair = "name of keypair"

min_size     = 2
max_size     = 5
desired_size = 2

environment = "dev"
