output "vault_instance_id" {
  value = aws_instance.vault.id
}

output "vault_private_ip" {
  value = aws_instance.vault.private_ip
}

output "vault_security_group_id" {
  value = aws_security_group.vault.id
}

output "vault_kms_key_arn" {
  value = var.vault_kms_key_arn
}

output "vault_s3_backend_bucket_arn" {
  value = var.vault_s3_backend_bucket_arn
}

output "vault_initialized" {
  value = false // à gérer via Ansible
}
