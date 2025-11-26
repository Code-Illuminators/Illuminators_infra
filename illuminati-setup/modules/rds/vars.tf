variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "vpc-id" {
  description = "The VPC ID where rds will be deployed"
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

variable "common_tags" {
  type = map(string)
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
