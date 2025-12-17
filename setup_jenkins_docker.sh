#!/bin/bash

echo "=============================="
echo " Jenkins + Docker Setup Start "
echo "=============================="

# 1. Update system
sudo apt update -y
sudo apt upgrade -y

# 2. Install Java 17
echo "Installing Java 17..."
sudo apt install openjdk-17-jdk -y

# 3. Install Git
echo "Installing Git..."
sudo apt install git -y

# 4. Install Maven
echo "Installing Maven..."
sudo apt install maven -y

# 5. Install Docker
echo "Installing Docker..."
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Add ubuntu user to docker group
sudo usermod -aG docker ubuntu

# 6. Install Jenkins
echo "Installing Jenkins..."

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install jenkins -y

# Start Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# 7. Add Jenkins user to Docker group
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

echo "=============================="
echo " Installation Completed ✅"
echo "=============================="

echo "Java Version:"
java -version

echo "Maven Version:"
mvn -version

echo "Git Version:"
git --version

echo "Docker Version:"
docker --version

echo "=============================="
echo " Jenkins URL:"
echo " http://<EC2-PUBLIC-IP>:8080"
echo "=============================="

echo "Initial Jenkins Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

