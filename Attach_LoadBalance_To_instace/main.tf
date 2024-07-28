#   Create a Load Balancer and attach two instances to it and create a target group and attach instances to it using terraform.




resource "aws_vpc" "My_VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main_VPC"
  }
}

resource "aws_subnet" "Subnet_1" {
  vpc_id     = aws_vpc.My_VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true
  tags = {
    name = "Subnet_1"
  }
}


resource "aws_subnet" "Subnet_2" {
  vpc_id     = aws_vpc.My_VPC.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true
    tags = {
        name = "Subnet_2"
    }
  
}

resource "aws_route_table_association" "this_rt_association" {
  subnet_id      = aws_subnet.Subnet_1.id
  route_table_id = aws_route_table.RouteTable.id
}

resource "aws_route_table_association" "this_rt2_association" {
  subnet_id      = aws_subnet.Subnet_2.id
  route_table_id = aws_route_table.RouteTable.id
  
}


resource "aws_internet_gateway" "My_IGW" {
  vpc_id = aws_vpc.My_VPC.id
  tags = {
    Name = "My_IGW"
  }
}

resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.My_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My_IGW.id
  }
  tags = {
    Name = "RouteTable"
  }
}

resource "aws_security_group" "My_SG" {
  name   = "Security_Group"
  vpc_id = aws_vpc.My_VPC.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "Main_SG"
  }

}

resource "aws_instance" "My_Instance_1" {
  ami             = var.aws_ami
  instance_type   = "t2.micro"
  key_name        = var.security_key
  security_groups = [aws_security_group.My_SG.id]
  subnet_id       = aws_subnet.Subnet_1.id
  tags = {
    Name = "My_Instance_1"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo -i
                yum update -y
                yum install -y httpd
                systemctl start httpd
                echo "Hello is page from $HOSTNAME" >> /var/www/html/index.html
                EOF
}

resource "aws_instance" "My_Instance_2" {
  ami             = var.aws_ami
  instance_type   = "t2.micro"
  key_name        = var.security_key
  security_groups = [aws_security_group.My_SG.id]
  subnet_id       = aws_subnet.Subnet_2.id
  tags = {
    Name = "My_Instance_2"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo -i
                yum update -y
                yum install -y httpd
                systemctl start httpd
                echo "Hello is page from $HOSTNAME" >> /var/www/html/index.html
                EOF

}

resource "aws_lb_target_group" "My_TagetGroup" {
  name     = "MyTageGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.My_VPC.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }

}

resource "aws_lb_target_group_attachment" "this_attachment1" {
  target_group_arn = aws_lb_target_group.My_TagetGroup.arn
  target_id        = aws_instance.My_Instance_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "this_attachment2" {
  target_group_arn = aws_lb_target_group.My_TagetGroup.arn
  target_id        = aws_instance.My_Instance_2.id
  port             = 80
}

resource "aws_lb" "this_alb" {
  name               = "this-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.My_SG.id]
  subnets            = [aws_subnet.Subnet_1.id, aws_subnet.Subnet_2.id]
  enable_deletion_protection = false
  tags = {
    Name = "this-alb"

  }

}

resource "aws_alb_listener" "this_listener" {
  load_balancer_arn = aws_lb.this_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.My_TagetGroup.arn
  } 
  
}