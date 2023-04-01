provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "my-tf-de-s3-bucket"
    acl = "private"
}
