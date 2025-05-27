output "config_recorder_name" {
  value = aws_config_configuration_recorder.recorder.name
}

output "delivery_channel_name" {
  value = aws_config_delivery_channel.channel.name
}

output "config_bucket_name" {
  value = aws_s3_bucket.config.id
}
