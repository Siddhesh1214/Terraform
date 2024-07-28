variable "aws_vpc_cidr_block" {
    type = string  
}

variable "aws_vpc_name" {
    type = string  
}

variable "aws_subnet_pub_cidr_block" {
    type = string  
}

variable "aws_subnet_pub_name" {
    type = string  
}

variable "aws_subnet_pvt_cidr_block" {
    type = string  
}

variable "aws_subnet_pvt_name" {
    type = string  
}

variable "aws_subnet_pvt2_cidr_block" {
    type = string
}

variable "aws_subnet_pvt2_name" {
    type = string
}

variable "aws_internet_gateway_name" {
    type = string  
}

variable "aws_default_route_table_cidr_block" {
   type=string
}