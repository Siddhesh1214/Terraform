module "vpc" {
    source = "../../Resources/VPC"
    aws_vpc_cidr_block = "14.12.0.0/16"
    aws_vpc_name = "my_vpc"
    aws_subnet_pub_cidr_block ="14.12.0.0/17"
    aws_subnet_pub_name = "my_pub_sub"
    aws_subnet_pvt_cidr_block = "14.12.128.0/19"
    aws_subnet_pvt_name = "my_pvt1_sub"
    aws_subnet_pvt2_cidr_block = "14.12.192.0/20"
    aws_subnet_pvt2_name = "my_pvt2_sub"
    aws_internet_gateway_name = "SG_igw"
    aws_default_route_table_cidr_block = "0.0.0.0/0"
}

module "EC2" {
    source = "../../Resources/EC2"
    ec2_instance_type = "t3.micro"
    ec2_key_name = "temp"
    ec2_tag_name =  "master_jenkins"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}