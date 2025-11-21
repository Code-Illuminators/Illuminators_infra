resource "aws_iam_role" "eks-node-role" {
  name = "eks-node-role-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-worker-policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])
  role       = aws_iam_role.eks-node-role.name
  policy_arn = each.value
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = "${var.cluster-name}-${var.env}"
  node_group_name = "illuminati-node-group-${var.env}"
  node_role_arn   = aws_iam_role.eks-node-role.arn
  subnet_ids = [
    data.aws_subnet.private-eks-subnet-a.id,
    data.aws_subnet.private-eks-subnet-b.id
  ]

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  instance_types = var.node-instance-type

  depends_on = [aws_iam_role_policy_attachment.eks-worker-policies]
}
