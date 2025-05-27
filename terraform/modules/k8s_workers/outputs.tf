output "asg_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.k8s_workers_asg.name
}

output "lt_id" {
  description = "Launch Template ID"
  value       = aws_launch_template.k8s_worker_lt.id
}
output "worker_sg_id" {
  description = "Security Group ID attached to worker instances"
  value       = var.security_group_id
}