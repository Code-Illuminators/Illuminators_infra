#!/bin/bash
sudo dnf update -y

sudo dnf install java-17-amazon-corretto -y


sudo wget -O /etc/yum.repos.d/jenkins.repo \
 https://pkg.jenkins.io/redhat-stable/jenkins.repo
              
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              
sudo dnf upgrade -y

sudo dnf install jenkins -y

sudo systemctl enable jenkins

sudo systemctl start jenkins

sudo dnf update -y

sudo dnf install -y docker

sudo systemctl enable docker

sudo systemctl start docker

sudo dnf install -y git

sudo usermod -aG docker jenkins

sudo systemctl restart jenkins