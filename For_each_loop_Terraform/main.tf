# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


#-------------------- For_each_loop ---------------------#
provider "aws" {
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "this_instance" {
    for_each = toset(var.aws_ami)
    ami = each.value
    key_name = "sid"
    instance_type = "t2.micro"
}

variable "aws_ami" {
    type = list(string)
    default = [ "ami-0eb5115914ccc4bc2","ami-08f7912c15ca96832","ami-0f7197c592205b389","ami-011fa029a966edf23" ]
  
}