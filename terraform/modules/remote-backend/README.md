# 📦 Module Terraform - remote-backend

Ce module crée un bucket S3 sécurisé destiné à être utilisé comme **remote backend Terraform**.

> ⚠️ Ce module **n’inclut pas DynamoDB**, car il est conçu pour une utilisation individuelle sans verrouillage d’état.

## ✅ Ressources créées

- `aws_s3_bucket` : bucket S3 avec chiffrement AES256
- `aws_s3_bucket_versioning` : versioning activé
- `aws_s3_bucket_server_side_encryption_configuration` : chiffrement côté serveur

## 🔧 Variables

| Nom           | Type   | Description                                        | Défaut |
|----------------|--------|----------------------------------------------------|--------|
| `bucket_name` | string | Nom du bucket S3 à créer                           | —      |
| `environment` | string | Environnement (`dev`, `staging`, `prod`, etc.)     | `"dev"`|

## 📤 Outputs

| Nom                            | Description                          |
|--------------------------------|--------------------------------------|
| `remote_backend_bucket_name`   | Nom du bucket S3                     |
| `remote_backend_bucket_arn`    | ARN du bucket S3                     |

## 📦 Exemple d'utilisation

```hcl
module "remote_backend" {
  source      = "../modules/remote-backend"
  bucket_name = "my-tf-backend-sharepictures"
  environment = "prod"
}
