output "vault_backend_bucket_arn" {
  value = module.vault-backend.vault_backend_bucket_arn
}

output "uploads_bucket_arn" {
  value = module.app-uploads.uploads_bucket_arn

}
