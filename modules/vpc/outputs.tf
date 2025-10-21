output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "jenkins_private_subnet_id" {
  value = aws_subnet.jenkins_private_subnet.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}
