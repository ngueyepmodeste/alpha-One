output "master_instance_id" {
  description = "ID of the Kubernetes master EC2 instance"
  value       = aws_instance.k8s_master.id
}

output "master_private_ip" {
  description = "Private IP of the master node"
  value       = aws_instance.k8s_master.private_ip
}

output "master_private_dns" {
  description = "Private DNS name of the master node"
  value       = aws_instance.k8s_master.private_dns
}
