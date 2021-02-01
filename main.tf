provider "aws" {
   access_key = "AKIAX7IDMWNITE6TGYRZ"
   secret_key = "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"
   region = "us-west-2"
}

resource "aws_s3_bucket" "mybucket" {
    bucket  = "qts3frmtf"
    tags = {
      Name        = "My bucket"
      Environment = "Dev"
      CreatedBy   = "Terraform"
    }
}

resource "aws_vpc" "myvpc" {
    cidr_block          = "192.168.0.0/16"
    enable_dns_support  = true
    tags = {
        Name = "fromtf"
    }
}


resource "aws_subnet" "web" {
    vpc_id            = aws_vpc.myvpc.id
    cidr_block        = "192.168.0.0/24"
    availability_zone = "us-west-2a"

    tags = {
        Name = "web"
    }
  
}

resource "aws_subnet" "app" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "192.168.1.0/24"
    availability_zone       = "us-west-2b"

    tags = {
        Name = "app"
    }

}

resource "aws_subnet" "db" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "192.168.2.0/24"
    availability_zone       = "us-west-2c"

    tags = {
        Name = "db"
    }

}

resource "aws_subnet" "mgmt" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = "192.168.3.0/24"
    availability_zone       = "us-west-2a"

    tags = {
        Name = "mgmt"
    }

}