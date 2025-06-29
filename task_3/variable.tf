
variable "ami" {
  description = "Ubuntu"
  default     = "ami-0c2b8ca1dad447f8a" 
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  default     = "nvmel92"
}


variable "public_subnets" {
  default = "10.0.1.0/24"
}

variable "private_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}