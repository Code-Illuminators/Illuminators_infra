env               = "stage-01"
region            = "us-east-1"
availability-zone = "us-east-1a"
#private-subnets-for-consul = "10.0.7.0/24"
account-id = "037490753541"

#private-subnets-for-consul
private-subnet-a-cidr = "10.0.11.0/24"
private-subnet-b-cidr = "10.0.12.0/24"
private-subnet-c-cidr = "10.0.13.0/24"

#az-for-consul
az-a = "us-east-1a"
az-b = "us-east-1b"
az-c = "us-east-1c"

private-eks-subnet-a = "10.0.14.0/24"
private-eks-subnet-b = "10.0.15.0/24"
public-eks-subnet-a  = "10.0.16.0/24"
public-eks-subnet-b  = "10.0.17.0/24"
cluster-name         = "Illuminati-cluster"
eks-k8s-version      = "1.31"
