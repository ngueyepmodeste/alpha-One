# ✅ Module AWS Config

Configure AWS Config avec un bucket S3 sécurisé et une livraison automatique des événements.

## 📥 Inputs

| Variable          | Description                           |
|-------------------|---------------------------------------|
| project_name      | Nom du projet                         |
| environment       | Environnement (dev, prod, etc.)       |
| config_role_arn   | ARN du rôle IAM pour AWS Config       |

## 📤 Outputs

| Output                 | Description                     |
|------------------------|---------------------------------|
| config_recorder_name   | Nom du recorder AWS Config      |
| delivery_channel_name  | Nom du delivery channel         |
| config_bucket_name     | Bucket S3 associé à Config      |

## ✅ Exemple d’appel

```hcl
module "aws_config" {
  source          = "./aws-config"
  project_name    = var.project_name
  environment     = var.environment
  config_role_arn = var.config_role_arn
}
