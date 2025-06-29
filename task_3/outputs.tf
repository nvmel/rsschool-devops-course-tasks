output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = aws_instance.bastion.public_ip
}

output "k3s_master_private_ip" {
  description = "Private IP of the K3s master node"
  value       = aws_instance.k3s_master.private_ip
}

output "k3s_worker_private_ip" {
  description = "Private IP of the K3s worker node"
  value       = aws_instance.k3s_worker.private_ip
}