terraform {
  backend "s3" {
    bucket = "nmel-tf-state"
    key    = "s3/tf-state"
    region = "us-east-1"
  }
}
