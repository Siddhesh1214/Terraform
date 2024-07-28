# provider "aws" {
#     region = "us-west-2"
#     profile = "confifs"
#     shared_credentials_files = ["/home/sidd/.aws/credentials"]
# }

# terraform {
#   backend "s3" {
#     bucket = "terraform-state-b24"
#     key = "terraform.tfstate"
#     dynamodb_table = "dynamo_key"
#     region = "us-west-2"
#     profile = "confifs"
#     shared_credentials_files = ["/home/sidd/.aws/credentials"]
#   }
# }