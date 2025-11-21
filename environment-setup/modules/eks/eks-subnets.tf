resource "aws_subnet" "private-eks-subnet-a" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-eks-subnet-a
  availability_zone = var.az-a
  tags = merge(var.common_tags_illuminati, {
    "Name"                                                 = "private-eks-subnet-a-${var.env}-${var.cluster-name}"
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = "owned"
    "kubernetes.io/role/internal-elb"                      = "1"
  })
}

resource "aws_subnet" "private-eks-subnet-b" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-eks-subnet-b
  availability_zone = var.az-b
  tags = merge(var.common_tags_illuminati, {
    "Name"                                                 = "private-eks-subnet-b-${var.env}-${var.cluster-name}"
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = "owned"
    "kubernetes.io/role/internal-elb"                      = "1"
  })
}

resource "aws_subnet" "public-eks-subnet-a" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.public-eks-subnet-a
  availability_zone       = var.az-a
  map_public_ip_on_launch = true
  tags = merge(var.common_tags_illuminati, {
    "Name"                                                 = "public-eks-subnet-b-${var.env}-${var.cluster-name}"
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = "owned"
    "kubernetes.io/role/elb"                               = "1"
  })
}

resource "aws_subnet" "public-eks-subnet-b" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.public-eks-subnet-b
  availability_zone       = var.az-b
  map_public_ip_on_launch = true
  tags = merge(var.common_tags_illuminati, {
    "Name"                                                 = "public-eks-subnet-b-${var.env}-${var.cluster-name}"
    "kubernetes.io/cluster/${var.cluster-name}-${var.env}" = "owned"
    "kubernetes.io/role/elb"                               = "1"
  })
}
