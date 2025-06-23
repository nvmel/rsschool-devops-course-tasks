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
  subnet_id              = var.public_subnets.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "BastionHost"
  }
}

# Private EC2 Instance
resource "aws_instance" "private" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "PrivateInstance"
  }
}