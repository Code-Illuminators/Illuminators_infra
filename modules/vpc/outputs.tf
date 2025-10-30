output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "private_subnet_id" {
  value = aws_subnet.jenkins_private_subnet.id
}
