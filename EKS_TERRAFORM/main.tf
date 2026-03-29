
# -----------------------------
# VPC & Subnets
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
# IAM Roles
# -----------------------------
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "fargate_pod_execution_role" {
  name = "eks-fargate-pod-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks-fargate-pods.amazonaws.com" }
    }]
  })
  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }
}

resource "aws_iam_role_policy_attachment" "fargate_policy" {
  role       = aws_iam_role.fargate_pod_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

# -----------------------------
# EKS Cluster
# -----------------------------
resource "aws_eks_cluster" "eks_cluster" {
  name     = "devops-eks-cluster"
  version  = "1.25"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = [
      data.aws_subnets.default.ids[0],
      data.aws_subnets.default.ids[1],
      data.aws_subnets.default.ids[2]
    ]
    endpoint_public_access  = true
    endpoint_private_access = false
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]

  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

# -----------------------------
# Fargate Profile
# -----------------------------
resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = "devops-fargate-profile"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
  subnet_ids             = [
    data.aws_subnets.default.ids[0],
    data.aws_subnets.default.ids[1],
    data.aws_subnets.default.ids[2]
  ]

  selector {
    namespace = "default"
  }

  tags = {
    Owner   = "DevOpsFactory"
    Project = "DevOps-EKS"
  }

  depends_on = [aws_iam_role_policy_attachment.fargate_policy]
}

# -----------------------------
# Node.js Deployment + LoadBalancer
# -----------------------------
resource "kubernetes_deployment" "nodejs_app" {
  metadata {
    name      = "nodejs-app"
    namespace = "default"
    labels = { app = "nodejs-app" }
  }

  spec {
    replicas = 1
    selector {
      match_labels = { app = "nodejs-app" }
    }
    template {
      metadata {
        labels = { app = "nodejs-app" }
      }
      spec {
        container {
          name  = "nodejs"
          image = "<YOUR_NODEJS_DOCKER_IMAGE>" # replace with your image
          port { container_port = 3000 }
        }
      }
    }
  }
}

resource "kubernetes_service" "nodejs_lb" {
  metadata {
    name      = "nodejs-service"
    namespace = "default"
  }

  spec {
    selector = { app = "nodejs-app" }
    type     = "LoadBalancer"
    port {
      port        = 80
      target_port = 3000
    }
  }
}

# -----------------------------
# Outputs
# -----------------------------
output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "fargate_role_arn" {
  value = aws_iam_role.fargate_pod_execution_role.arn
}

output "nodejs_service_lb" {
  value = kubernetes_service.nodejs_lb.status[0].load_balancer[0].ingress[0].hostname
}
