output "jenkins_instance_id" {
  value = aws_instance.jenkins_ec2.id
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins_sg.id
}
