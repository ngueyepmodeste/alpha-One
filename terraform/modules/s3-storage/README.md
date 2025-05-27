# Module Terraform: s3/

Ce module crée deux buckets S3 :

1. 🔐 **vault-backend/** : Bucket utilisé par l'instance Vault comme backend de stockage.
2. 🖼️ **app-uploads/** : Bucket pour stocker les fichiers téléchargés par les utilisateurs de l’application.

---

## 📦 Ressources créées

- Deux buckets S3 avec encryption SSE-S3
- Blocage de l'accès public
- (Optionnel) Configuration de versioning, de policy ou de lifecycle (ajustable)

---

## 📥 Entrées (`variables.tf`)

| Variable                 | Description                                      | Type     | Requis |
|--------------------------|--------------------------------------------------|----------|--------|
| `project_name`           | Préfixe pour nommer les buckets S3              | `string` | ✅     |
| `environment`            | Environnement (dev, staging, prod…)             | `string` | ✅     |
| `vault_backend_enabled`  | Créer le bucket Vault backend ?                 | `bool`   | ✅     |
| `uploads_enabled`        | Créer le bucket pour les uploads ?              | `bool`   | ✅     |
| `region`                 | Région AWS pour le déploiement                  | `string` | ✅     |

---

## 📤 Outputs

### 🪣 Buckets généraux

| Output         | Description                                |
|----------------|--------------------------------------------|
| `bucket_name`  | Nom générique du bucket principal (si utilisé) |
| `bucket_arn`   | ARN du bucket principal                   |

### 🔐 Vault Backend Bucket

| Output                         | Description                          |
|--------------------------------|--------------------------------------|
| `vault_backend_bucket_name`   | Nom du bucket Vault backend          |
| `vault_backend_bucket_arn`    | ARN du bucket Vault backend          |
| `vault_backend_bucket_region` | Région du bucket Vault               |

### 🖼️ Uploads Bucket

| Output               | Description                          |
|----------------------|--------------------------------------|
| `uploads_bucket_name`| Nom du bucket pour les uploads       |
| `uploads_bucket_arn` | ARN du bucket pour les uploads       |

---

## 🧪 Exemple d'utilisation

```hcl
module "s3" {
  source = "./modules/s3"

  project_name          = "myproject"
  environment           = "dev"
  region                = "eu-west-3"

  vault_backend_enabled = true
  uploads_enabled       = true
}
