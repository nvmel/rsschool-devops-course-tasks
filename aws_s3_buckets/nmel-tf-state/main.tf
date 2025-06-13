provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "nmel-tf-state" {
  bucket = "nmel-tf-state"  


}