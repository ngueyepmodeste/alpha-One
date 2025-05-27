variable "backup_vault_name" {
  description = "Name of the backup vault"
  type        = string
}

variable "backup_plan_name" {
  description = "Name of the backup plan"
  type        = string
}

variable "rule_name" {
  description = "Name of the backup rule"
  type        = string
}

variable "schedule" {
  description = "Cron expression for backup schedule"
  type        = string
}

variable "start_window" {
  description = "Time in minutes to start the backup"
  type        = number
}

variable "completion_window" {
  description = "Time in minutes to complete the backup"
  type        = number
}

variable "delete_after_days" {
  description = "Days after which to delete the backup"
  type        = number
}

variable "selection_name" {
  description = "Name of the backup selection"
  type        = string
}

variable "iam_role_arn" {
  description = "IAM Role ARN for AWS Backup"
  type        = string
}

variable "resources_to_backup" {
  description = "List of ARNs to back up (e.g. EBS volumes, RDS)"
  type        = list(string)
}
