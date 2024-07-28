#Creating Backend Using terraform And apply state lock

# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


terraform {
  backend "s3" {
    bucket = "terraform-state-b24"
    key = "terraform.tfstate"
    dynamodb_table = "dynamo_key"
    region = "us-west-2"
    profile = "confifs"
    shared_credentials_files = ["/home/sidd/.aws/credentials"]
  }
}



resource "aws_instance" "this_aws_instance"{
  ami               = "ami-08f7912c15ca96832"
  instance_type     = "t2.micro"
  key_name          = "temp"
  count     = 1
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

  tags = {
      Name =  "Master_jenkins"
 }
}