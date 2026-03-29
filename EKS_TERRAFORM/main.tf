# -----------------------------
# Provider
# -----------------------------
provider "aws" {
  region = "ap-south-1"  # change if needed
}

# -----------------------------
# Get Default VPC
# -----------------------------
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# -----------------------------
# Private Subnets (update tags)
# -----------------------------
resource "aws_subnet" "private_subnet_1" {
  id = "subnet-0fa21ef1f0a8c9922" # your private subnet
  tags = {
    Name    = "private-subnet-1"
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
    Tier    = "private"
  }
}

resource "aws_subnet" "private_subnet_2" {
  id = "subnet-08e05736e563c3434" # your private subnet
  tags = {
    Name    = "private-subnet-2"
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
    Tier    = "private"
  }
}

# -----------------------------
# EKS Cluster (match existing version!)
# -----------------------------
resource "aws_eks_cluster" "eks_cluster" {
  name     = "devops-eks-cluster"
  role_arn = "arn:aws:iam::679968874516:role/eks-cluster-role" # your cluster IAM role

  version = "1.32" # match existing to avoid downgrade

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id
    ]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }
}

# -----------------------------
# IAM Role for Fargate Pod Execution
# -----------------------------
resource "aws_iam_role" "eks_fargate_pod_execution_role" {
  name = "eks-fargate-pod-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
  })

  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }
}

resource "aws_iam_role_policy_attachment" "eks_fargate_attach" {
  role       = aws_iam_role.eks_fargate_pod_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

# -----------------------------
# Fargate Profile
# -----------------------------
resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = "devops-fargate-profile"
  pod_execution_role_arn = aws_iam_role.eks_fargate_pod_execution_role.arn
  subnet_ids             = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  selector {
    namespace = "default"
  }

  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }
}

# -----------------------------
# Admin IAM Role
# -----------------------------
resource "aws_iam_role" "eks_admin_role" {
  name = "EKS-Admin-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          AWS = "arn:aws:iam::679968874516:root"
        }
      }
    ]
  })

  max_session_duration = 3600

  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }
}

resource "aws_iam_role_policy_attachment" "eks_admin_attach" {
  role       = aws_iam_role.eks_admin_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
