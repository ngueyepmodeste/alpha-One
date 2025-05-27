resource "aws_s3_bucket" "remote_backend" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.remote_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.remote_backend.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
