output "vault_backend_bucket_name" {
  value = aws_s3_bucket.vault_backend.id
}

output "vault_backend_bucket_arn" {
  value = aws_s3_bucket.vault_backend.arn
}

output "vault_backend_bucket_region" {
  value = data.aws_region.current.name
}

data "aws_region" "current" {}
