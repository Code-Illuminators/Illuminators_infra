data "aws_eks_cluster" "eks" {
  name = "${var.cluster-name}-${var.env}"
}

data "aws_eks_cluster_auth" "eks" {
  name = "${var.cluster-name}-${var.env}"
}
