# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


#----------------- Method - 1 ----------------------

# provider "aws" {
#   access_key = ""
#   secret_key = ""
# }

resource "aws_iam_user" "this_users" {
    name = "linux.${count.index}"
    count = 3
}

#-------------------- Method - 2 -------------------------
# provider "aws" {
#   access_key = ""
#   secret_key = ""
# }

resource "aws_iam_user" "this_users" {
    name = var.aws_user_name[count.index]
    count = length(var.aws_user_name)
}

variable "aws_user_name" {
    type = list(string)
    default = ["ubuntu", "linux", "solaris", "kali"]
}