
---

## 🖼️ `s3/app-uploads/README.md`

```markdown
# 🖼️ Module S3 – App Uploads

Ce sous-module crée un bucket S3 sécurisé pour le stockage des fichiers envoyés par les utilisateurs (photos, documents, etc.).  
Il est encrypté côté serveur (AES256) et aucune permission publique n’est autorisée.

## 📥 Inputs

| Variable       | Type   | Description                          |
|----------------|--------|--------------------------------------|
| project_name   | string | Nom du projet                        |
| environment    | string | Environnement (dev, prod, etc.)      |

## 📤 Outputs

| Output                  | Description                          |
|-------------------------|--------------------------------------|
| uploads_bucket_name     | Nom du bucket S3                     |
| uploads_bucket_arn      | ARN du bucket S3                     |

## ✅ Exemple d’appel dans `main.tf`

```hcl
module "uploads" {
  source        = "./s3/app-uploads"
  project_name  = var.project_name
  environment   = var.environment
}
