data "aws_eks_cluster" "eks" {
  name = "${var.cluster-name}-${var.env}"
}

data "aws_eks_cluster_auth" "eks" {
  name = "${var.cluster-name}-${var.env}"
}

data "aws_subnet" "private-eks-subnet-a" {
  tags = {
    Name = "private-eks-subnet-a-${var.env}-${var.cluster-name}"
  }
}

data "aws_subnet" "private-eks-subnet-b" {
  tags = {
    Name = "private-eks-subnet-b-${var.env}-${var.cluster-name}"
  }
}
