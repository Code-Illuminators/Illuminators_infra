resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.main_vpc.id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "jenkins_sg"
  }

}