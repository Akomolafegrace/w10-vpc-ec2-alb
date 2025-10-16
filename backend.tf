terraform {
  backend "s3" {
    bucket  = "mygrace-s3-bucket" #replace with your bucket
    key     = "week10/ terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    // dynamobd_table = "locktable"      #replace with the table
  }
}
