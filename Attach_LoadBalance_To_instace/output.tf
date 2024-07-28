output "aws_instance1_ip" {
  value = aws_instance.My_Instance_1.public_ip
}

output "aws_instance2_ip" {
  value = aws_instance.My_Instance_2.public_ip
}

output "aws_lb_dns" {
  value = aws_lb.this_alb.dns_name
}


