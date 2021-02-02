terraform {
  backend "s3" {
        bucket          = "qtfortfstate"
        key             = "global/ntier/terraform.tfstate"
        region          = "us-west-2"

        dynamodb_table  = "qttablefortflock"

  }

}