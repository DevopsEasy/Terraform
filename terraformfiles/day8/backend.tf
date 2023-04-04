terraform {
  backend "s3" {
    bucket = "de-s3-backend"
    key    = "terraform.tfstate"
    region = "us-west-2"

  }
}

