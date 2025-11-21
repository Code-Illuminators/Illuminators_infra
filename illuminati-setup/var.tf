variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "cluster-name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "private-db-subnet-a" {
  description = "CIDR block for private DB subnet A"
  type        = string
}

variable "private-db-subnet-b" {
  description = "CIDR block for private DB subnet B"
  type        = string
}

variable "availability-zone-a" {
  description = "First availability zone for db subnet"
  type        = string
}

variable "availability-zone-b" {
  description = "Second availability zone for db subnet"
  type        = string
}

variable "db-password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true

}

variable "db-user" {
  description = "The username for the RDS database"
  type        = string
  sensitive   = true
}

variable "db-name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db-port" {
  description = "The port for the RDS database"
  type        = string
}

variable "node-instance-type" {
  description = "The instance type for the EKS worker nodes"
  type        = list(string)
}

variable "external-dns-chart" {
  description = "The external-dns helm chart path"
  type        = string
}

variable "frontend-chart" {
  description = "The frontend helm chart path"
  type        = string
}

variable "backend-chart" {
  description = "The backend helm chart path"
  type        = string
}

variable "domain-name" {
  description = "The domain name for app"
  type        = string
}

variable "account-id" {
  description = "The AWS account ID"
  type        = string
}

variable "aws-load-balancer-controller-chart" {
  description = "The aws load balancer controller helm chart path"
  type        = string
}

variable "ingress-class-chart" {
  description = "The ingress class helm chart path"
  type        = string
}
