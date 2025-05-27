resource "aws_s3_bucket" "vault_backend" {
  bucket = "${var.project_name}-${var.environment}-vault-backend"
  force_destroy = true

  tags = {
    Name        = "vault-backend"
    Environment = var.environment
  }
}


resource "aws_s3_bucket_public_access_block" "vault_backend" {
  bucket = aws_s3_bucket.vault_backend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "vault_backend" {
  bucket = aws_s3_bucket.vault_backend.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# bucket du remote backend pour securiser le tfstate
##################################################################
