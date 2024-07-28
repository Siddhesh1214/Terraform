#Creating User And Give perssion using Docker

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

#-----------Create a new policy ------------#
resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#-----------Give a policy to a group Directly------------#
resource "aws_iam_group_policy_attachment" "policy_attachment" {
    group = aws_iam_group.this_iam-group.name  
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}