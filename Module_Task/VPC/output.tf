output "vpc_id" {
    value = aws_vpc.this_vpc.id
}

output "subnet_id" {
  value = aws_subnet.subnet_pub.id
}