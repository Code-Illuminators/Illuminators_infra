#!/bin/bash

sudo dnf update -y
sudo dnf install -y java-17-amazon-corretto git docker

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo dnf upgrade -y
sudo dnf install -y jenkins

sudo usermod -aG docker jenkins

sudo systemctl enable docker jenkins
sudo systemctl start docker jenkins
