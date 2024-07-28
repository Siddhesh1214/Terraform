resource "aws_vpc" "this_vpc" {
    cidr_block = var.aws_vpc_cidr_block //"14.12.0.0/16"
    tags = {
          name = var.aws_vpc_name //"my_vpc"
    }
}

resource "aws_subnet" "subnet_pub" {
    vpc_id = aws_vpc.this_vpc.id
    cidr_block = var.aws_subnet_pub_cidr_block //"14.12.0.0/17"
    tags = {
      name = var.aws_subnet_pub_name//"my_pub_sub"
    }
}

resource "aws_subnet" "subnet_pvt" {
    vpc_id = aws_vpc.this_vpc.id
    cidr_block = var.aws_subnet_pvt_cidr_block //"14.12.128.0/19" 
    tags = {
      name = var.aws_subnet_pvt_name //"my_pvt1_sub"
    }
}

resource "aws_subnet" "subnet_pvt2" {
    vpc_id = aws_vpc.this_vpc.id
    cidr_block = var.aws_subnet_pvt2_cidr_block //"14.12.192.0/20"
    tags = {
      name = var.aws_subnet_pvt2_name //"my_pvt2_sub"
    }
  
}


resource "aws_internet_gateway" "this_igw" {
    vpc_id = aws_vpc.this_vpc.id
    tags = {
      name = var.aws_internet_gateway_name //"SG_igw"
    }
}

resource "aws_default_route_table" "this_rt" {
    default_route_table_id = aws_vpc.this_vpc.default_route_table_id
    
    route {
        cidr_block = var.aws_default_route_table_cidr_block //"0.0.0.0/0"
        gateway_id = aws_internet_gateway.this_igw.id
    }
}

resource "aws_route_table_association" "this_route" {
    subnet_id = aws_subnet.subnet_pub.id
    route_table_id = aws_default_route_table.this_rt.id

}

resource "aws_eip" "this_ip" {
domain = "vpc"
tags = {
  Name= "Elastic_IP"
}
}


resource "aws_nat_gateway" "this_nat_gateway" {
  allocation_id = aws_eip.this_ip.id 
  subnet_id     = aws_subnet.subnet_pub.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

# e.g., Create subnets in the first two available availability zones

# resource "aws_subnet" "primary" {
#   availability_zone = data.aws_availability_zones.available.names[0]

# }

# resource "aws_subnet" "secondary" {
#   availability_zone = data.aws_availability_zones.available.names[1]
# }