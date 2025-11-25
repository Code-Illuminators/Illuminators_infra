module "environment-vpc" {
  source            = "./modules/vpc/"
  vpc-id            = data.aws_vpc.account-vpc.id
  env               = var.env
  availability-zone = var.availability-zone
  region            = var.region
  common_tags       = local.common_tags
}

module "s3-photo-bucket" {
  source = "./modules/s3-photo-bucket"
  env    = var.env
}

module "eks-setup" {
  source                 = "./modules/eks/"
  vpc-id                 = data.aws_vpc.account-vpc.id
  env                    = var.env
  region                 = var.region
  private-eks-subnet-a   = var.private-eks-subnet-a
  private-eks-subnet-b   = var.private-eks-subnet-b
  public-eks-subnet-a    = var.public-eks-subnet-a
  public-eks-subnet-b    = var.public-eks-subnet-b
  cluster-name           = var.cluster-name
  eks-k8s-version        = var.eks-k8s-version
  private-route-table-id = module.environment-vpc.private-route-table-id
  public-route-table-id  = module.environment-vpc.public-route-table-id
}
