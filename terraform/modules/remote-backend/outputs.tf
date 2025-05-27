output "remote_backend_bucket_name" {
  value = aws_s3_bucket.remote_backend.bucket
}

output "remote_backend_bucket_arn" {
  value = aws_s3_bucket.remote_backend.arn
}
