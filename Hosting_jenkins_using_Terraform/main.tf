#Hosting Jenkins using Terraform

# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


resource "aws_instance" "my_instance" {
  ami           = "ami-08f7912c15ca96832"  # Ubuntu 20.04 LTS (Free tier eligible)
  instance_type = "t2.micro"  # Change this to your desired instance type
  key_name          = "temp" # Change this to your desired 

  tags = {
    Name = "Master_jenkins"
  }
  user_data = <<-EDF
  #!/bin/bash
  sudo -i
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
  echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update
  sudo apt-get install jenkins -y
  sudo apt install fontconfig openjdk-17-jre -y
  sudo systemctl start jenkins
    
    EDF
}