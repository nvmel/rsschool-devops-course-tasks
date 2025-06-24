locals {
  azs = ["us-east-1a", "us-east-1b"]

}
# Bastion Security Group (allows SSH from the internet)
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from internet"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private EC2 Security Group (only allows SSH from bastion)
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Allow SSH only from bastion"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Bastion Host EC2
resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true
  availability_zone = local.azs[0]

  tags = {
    Name = "BastionHost"
  }
}

# Private EC2 Instance
resource "aws_instance" "private" {
  count = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets[count.index]
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  associate_public_ip_address = false
  availability_zone = local.azs[count.index]

  tags = {
    Name = "PrivateInstance"
  }
}

# Public EC2 Instance
resource "aws_instance" "public" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets[1]
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  associate_public_ip_address = false
  availability_zone = local.azs[1]

  tags = {
    Name = "PublicInstance"
  }
}