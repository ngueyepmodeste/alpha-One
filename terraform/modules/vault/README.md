# Module Terraform: vault/

Ce module déploie une instance EC2 privée dans un VPC pour héberger **HashiCorp Vault**.  
L'instance utilise un bucket S3 existant comme backend de stockage et une clé KMS existante pour le chiffrement.

---

## 📦 Ressources créées

- Une instance EC2 pour Vault (AMI personnalisable)
- Un groupe de sécurité autorisant l’accès au port 8200 (Vault) uniquement depuis les IPs autorisées

---

## 📥 Entrées (`variables.tf`)

| Variable                          | Description                                                  | Type          | Requis |
|----------------------------------|--------------------------------------------------------------|---------------|--------|
| `project_name`                   | Nom du projet utilisé pour nommer les ressources             | `string`      | ✅     |
| `vpc_id`                         | ID du VPC dans lequel déployer l'instance                    | `string`      | ✅     |
| `subnet_id`                      | ID du sous-réseau privé                                      | `string`      | ✅     |
| `ami_id`                         | ID de l’AMI personnalisée (Ubuntu, etc.)                     | `string`      | ✅     |
| `instance_type`                  | Type d’instance EC2                                          | `string`      | ✅     |
| `key_pair_name`                  | Nom de la paire de clés SSH                                  | `string`      | ✅     |
| `ssh_user`                       | Utilisateur SSH (ex: ubuntu)                                 | `string`      | ✅     |
| `private_key_path`               | Chemin vers la clé privée pour l’accès SSH                   | `string`      | ✅     |
| `private_ip`                     | Adresse IP privée statique assignée à l’instance             | `string`      | ✅     |
| `allowed_ips`                   | Liste d’adresses CIDR autorisées à accéder à Vault (8200)    | `list(string)`| ✅     |
| `vault_s3_backend_bucket_name`  | Nom du bucket S3 existant pour le backend Vault              | `string`      | ✅     |
| `vault_kms_key_arn`             | ARN de la clé KMS existante pour le chiffrement              | `string`      | ✅     |

---

## 📤 Outputs

| Output                           | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| `vault_instance_id`             | ID de l’instance Vault                                       |
| `vault_private_ip`              | Adresse IP privée de Vault                                   |
| `vault_security_group_id`       | ID du groupe de sécurité de Vault                            |
| `vault_s3_backend_bucket_name`  | Nom du bucket S3 utilisé comme backend                       |
| `vault_kms_key_arn`             | ARN de la clé KMS utilisée                                   |
| `vault_initialized`             | Booléen indiquant si Vault a été initialisé (via Ansible)    |

---

## 🛠 Provisioning

L’initialisation, l’unsealing, et la configuration de Vault doivent être réalisés via Ansible ou un autre outil d’automatisation, en utilisant les outputs suivants : `vault_private_ip`, `ssh_user`, `private_key_path`.

---

## 🔒 Sécurité

- Le trafic entrant est restreint au port 8200 (Vault) aux IPs spécifiées dans `allowed_ips`.
- L'instance n'a pas d'adresse IP publique.
- Le backend S3 et la clé KMS sont **référencés** et non créés ici, afin de rester modulaires.
- L’accès au bucket S3 passe par les VPC Endpoints (pas d’Internet Gateway nécessaire).

---

## ✅ Pré-requis

- Bucket S3 et clé KMS déjà créés par les modules `s3/` et `kms/`
- VPC Endpoints S3 correctement configurés
- Bastion ou tunnel SSH configuré si accès manuel nécessaire

---

## 🧪 Exemple d'utilisation

```hcl
module "vault" {
  source = "./modules/vault"

  project_name                   = "myproject"
  vpc_id                         = module.network.vpc_id
  subnet_id                      = module.network.private_subnet_id
  ami_id                         = data.aws_ami.ubuntu.id
  instance_type                  = "t3.medium"
  key_pair_name                  = "my-keypair"
  ssh_user                       = "ubuntu"
  private_key_path               = "~/.ssh/my-key.pem"
  private_ip                     = "10.0.2.50"
  allowed_ips                    = ["10.0.0.0/16"]

  vault_s3_backend_bucket_name   = module.s3.vault_bucket_name
  vault_kms_key_arn              = module.kms.vault_kms_key_arn
}
