#Hosting static website on S3 bucket using Terraform

# provider "aws" {
#   region     = "Give_a_Region"
#   access_key = "Give_Access_Key"
#   secret_key = "Give_Secret_Key"


resource "aws_s3_bucket" "this_bucket" {
  bucket = "mys3buncket"
  tags = {
    Name = "Bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "this_ownership" {
  bucket = aws_s3_bucket.this_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "this_public_block" {
  bucket = aws_s3_bucket.this_bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "this_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.this_ownership,
    aws_s3_bucket_public_access_block.this_public_block,
    ]  

    bucket = aws_s3_bucket.this_bucket.id
    acl = "public-read"
}

resource "aws_s3_object" "this_object" {
  bucket = aws_s3_bucket.this_bucket.bucket
  key = "index.html"
  source = "/mnt/d/new.html"
  content_type = "text/html"
  etag = filemd5("/mnt/d/new.html")
  acl = "public-read"
}

resource "aws_s3_bucket_website_configuration" "this_web" {
  bucket = aws_s3_bucket.this_bucket.id
  index_document {
    suffix = "index.html"
  }

} 