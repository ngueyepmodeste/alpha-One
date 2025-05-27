# ✅ Module KMS

Crée une clé KMS avec rotation activée et un alias personnalisable.

## 📥 Inputs

| Variable         | Description                     |
|------------------|---------------------------------|
| kms_alias_name   | Nom de l’alias sans "alias/"    |

## 📤 Outputs

| Output             | Description                      |
|--------------------|----------------------------------|
| kms_key_id         | ID de la clé KMS                 |
| kms_key_arn        | ARN de la clé KMS                |
| kms_alias_name     | Nom complet de l’alias KMS       |

## ✅ Exemple d’appel

```hcl
module "kms" {
  source          = "./kms"
  kms_alias_name  = "my-key"
}
