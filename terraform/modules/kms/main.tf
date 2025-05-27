resource "aws_kms_key" "main" {
  description             = "KMS key for general encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.kms_alias_name}"
  target_key_id = aws_kms_key.main.id
}