output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

#output "private_instance_id" {
#  value = aws_instance.private.subnet_id
#}