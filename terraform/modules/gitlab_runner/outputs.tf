output "runner_public_ip" {
  value = aws_instance.runner.public_ip
}
output "runner_private_ip" {
  value = aws_instance.runner.private_ip
}
output "runner_instance_id" {
  value = aws_instance.runner.id
}
output "ansible_ready" {
  value = aws_instance.runner.id != "" && aws_instance.runner.public_ip != ""
}