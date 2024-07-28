# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"

resource "aws_sns_topic" "this_topic" {
  name = "SNS_prac"
  display_name = "sns_prac"
}

resource "aws_sns_topic_subscription" "this_sub" {
  protocol = "email"
  topic_arn = aws_sns_topic.this_topic.arn
  endpoint = "Give_your_email_id"
}
