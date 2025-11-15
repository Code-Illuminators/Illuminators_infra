output "private_subnet_jenkins_id" {
  description = "The id subnet Jenkins"
  value       = aws_subnet.private_subnet_jenkins.id
}

output "public_jenkins_key_name" {
  value = aws_key_pair.jenkins-key-pair.key_name
}
