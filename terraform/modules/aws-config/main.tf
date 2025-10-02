resource "aws_s3_bucket" "config" {
  bucket        = "${var.project_name}-${var.environment}-aws-config"
  force_destroy = true

  tags = {
    Name        = "aws-config-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "config" {
  bucket = aws_s3_bucket.config.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_policy" "config" {
  bucket = aws_s3_bucket.config.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AWSConfigReadOnly"
        Effect    = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = [
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy"
        ]
        Resource = aws_s3_bucket.config.arn
        Condition = {
          StringEquals = {
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      },
      {
        Sid       = "AWSConfigWrite"
        Effect    = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.config.arn}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl"         = "bucket-owner-full-control",
            "aws:RequestedRegion" = "us-east-1"
          }
        }
      }
    ]
  })
}

resource "aws_config_configuration_recorder" "recorder" {
  name     = "config-recorder"
  role_arn = var.config_role_arn

  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "channel" {
  name           = "config-delivery-channel"
  s3_bucket_name = aws_s3_bucket.config.bucket
  depends_on     = [aws_config_configuration_recorder.recorder]
}

resource "aws_config_configuration_recorder_status" "recorder_status" {
  name       = aws_config_configuration_recorder.recorder.name
  is_enabled = true
  depends_on = [
    aws_config_delivery_channel.channel
  ]
}
