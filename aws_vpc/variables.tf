variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair_name" {
  description = "SSH key name uploaded in AWS"
}

variable "azs" {
  description = "List of 2 AZs in the region"
  default     = ["us-east-1a", "us-east-1b"]
}