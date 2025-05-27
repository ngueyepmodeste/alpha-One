# 🔐 Module — Security Groups

Ce module crée tous les groupes de sécurité nécessaires à l’architecture complète :

## ✅ Groupes créés

| Nom | Description |
|-----|-------------|
| sg_bastion | Accès SSH depuis IPs autorisées |
| sg_master  | Communication K8s et SSH depuis bastion |
| sg_worker  | Accès ALB + communication control-plane |
| sg_alb     | HTTP/HTTPS ouvert au public |
| sg_runner  | SSH et egress complet |
| sg_vault   | HTTPS depuis sous-réseaux internes |

## 📥 Variables

- `vpc_id`
- `allowed_ssh_cidrs`
- `allowed_internal_cidrs`
- `project_name`
- `environment`

## 🧪 Exemple

```hcl
module "security_groups" {
  source                 = "./modules/security-groups"
  vpc_id                 = module.vpc_b.vpc_id
  allowed_ssh_cidrs      = ["X.X.X.X/32"]
  allowed_internal_cidrs = ["10.10.0.0/16", "192.168.0.0/16"]
  project_name           = "my-project"
  environment            = "dev"
}
