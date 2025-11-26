resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "eks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_eks_cluster" "eks-main-cluster" {
  name     = "${var.cluster-name}-${var.env}"
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.eks-k8s-version

  vpc_config {
    subnet_ids = [
      aws_subnet.private-eks-subnet-a.id,
      aws_subnet.private-eks-subnet-b.id
    ]
    endpoint_public_access  = true
    endpoint_private_access = true
  }
  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}


