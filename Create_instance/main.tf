// create an instance and security group in AWS using terraform.



provider "aws" {
  region     = "us-west-1"
  access_key = "AKIATGNV2F7TOKKXWKMH"
  secret_key = "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"

}
resource "aws_instance" "this_instance" {
  ami = "ami-07619059e86eaaaa2"
  instance_type = "t2.micro"
  availability_zone = "us-west-1c"
  vpc_security_group_ids = [aws_security_group.this_security_group.id]
    key_name = "sid"
  tags = {
    Name = "Instance_by_Siddhesh"
  }
  
}

resource "aws_security_group" "this_security_group" {
  name = "Sid_Security_Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  } 
  tags = {
    name = "Security_Group"
  }

}

