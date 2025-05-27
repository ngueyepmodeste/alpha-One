# 📦 Terraform Module — AWS Backup

Ce module permet de déployer une stratégie complète de sauvegarde AWS Backup incluant :
- Un **Backup Vault** (coffre de stockage)
- Un **Backup Plan** (planification de sauvegarde)
- Une **Backup Selection** (sélection des ressources à sauvegarder)

---

## 🔧 Utilisation

```hcl
module "backup" {
  source = "./modules/backup"

  backup_vault_name     = "my-backup-vault"
  backup_plan_name      = "daily-backup-plan"
  rule_name             = "daily-rule"
  schedule              = "cron(0 3 * * ? *)" # tous les jours à 3h UTC
  start_window          = 60
  completion_window     = 180
  delete_after_days     = 30
  selection_name        = "critical-resources"
  iam_role_arn          = aws_iam_role.aws_backup_role.arn

  resources_to_backup = [
    "arn:aws:ec2:eu-west-3:123456789012:instance/i-masterk8s",
    "arn:aws:ec2:eu-west-3:123456789012:instance/i-vault",
    "arn:aws:s3:::my-backup-bucket"
  ]
}
