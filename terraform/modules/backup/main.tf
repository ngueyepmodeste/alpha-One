resource "aws_backup_vault" "this" {
  name = var.backup_vault_name
}

resource "aws_backup_plan" "this" {
  name = var.backup_plan_name

  rule {
    rule_name         = var.rule_name
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule
    start_window      = var.start_window
    completion_window = var.completion_window
    lifecycle {
      delete_after = var.delete_after_days
    }
  }
}

resource "aws_backup_selection" "this" {
  name          = var.selection_name
  iam_role_arn  = var.iam_role_arn
  plan_id       = aws_backup_plan.this.id
  resources     = var.resources_to_backup
}
