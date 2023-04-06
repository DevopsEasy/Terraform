resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
      Name = "primary"
  }
}



resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  lifecycle {
    prevent_destroy = true
  }
  tags = {
      Name = "primary"
  }
}



resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  lifecycle {
    create_before_destroy = true
  }
  tags = {
      Name = "primary"
  }
}


resource "aws_vpc" "primary_vpc" {
  cidr_block = var.vpc_cidr
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
  tags = {
      Name = "primary"
  }
}

# to import 
## terraform import aws_vpc.myvpc <vpcid>

resource "aws_vpc" "myvpc" {}


 