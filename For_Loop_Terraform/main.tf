# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


#-------------------- For_each_loop ---------------------#
provider "aws" {
  access_key = "AKIAW7P4C3NNQMRYLQMY"
  secret_key = "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"
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

#-------------------- For_loop ---------------------#

output "aws_public_ip" {
  value = [for instance in var.aws_ami:
  aws_instance.this_instance[instance].public_ip]
}