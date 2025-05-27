output "iam_instance_profile_runner" {
  value = aws_iam_instance_profile.runner.name
}

output "iam_role_k8s_nodes" {
  value = aws_iam_role.k8s_nodes.arn
}

output "iam_role_backup" {
  value = aws_iam_role.backup.arn
}

output "iam_role_config" {
  value = aws_iam_role.config.arn
}
