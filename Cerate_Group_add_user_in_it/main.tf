# Create a Group And Add user in Group Using Terraform

# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


#------------Create a User------------#
resource "aws_iam_user" "this_user" {
    name = "User4"
    path = "/"

    tags = {
      name = "temp user"
    }
}


#-----------Giveing access Key To users------------#
resource "aws_iam_access_key" "this_iam-access-key"{
    user = aws_iam_user.this_user.name
}

#-----------Creating a group------------#
resource "aws_iam_group" "this_iam-group" {
    name = "temp_group"
    path = "/"
}

#-----------Add a User in Group------------#
resource "aws_iam_group_membership" "this_user_group_membership"{
    name = "this_member"
    users = [aws_iam_user.this_user.name]
    group = aws_iam_group.this_iam-group.name
}
