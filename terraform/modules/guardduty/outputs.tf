output "detector_id" {
  value = aws_guardduty_detector.main.id
}

output "guardduty_enabled" {
  value = aws_guardduty_detector.main.enable
}
