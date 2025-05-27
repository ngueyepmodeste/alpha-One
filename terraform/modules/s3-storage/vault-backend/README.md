# 🔐 Module S3 – Vault Backend

Ce sous-module crée un bucket S3 sécurisé dédié au backend de Vault.  
Le bucket est encrypté côté serveur (AES256), et l'accès public est totalement bloqué.

## 📥 Inputs

| Variable       | Type   | Description                          |
|----------------|--------|--------------------------------------|
| project_name   | string | Nom du projet                        |
| environment    | string | Environnement (dev, prod, etc.)      |

## 📤 Outputs

| Output                         | Description                                 |
|--------------------------------|---------------------------------------------|
| vault_backend_bucket_name      | Nom du bucket S3                            |
| vault_backend_bucket_arn       | ARN du bucket S3                            |
| vault_backend_bucket_region    | Région AWS du bucket                        |

## ✅ Exemple d’appel dans `main.tf`

```hcl
module "vault_backend" {
  source        = "./s3/vault-backend"
  project_name  = var.project_name
  environment   = var.environment
}
