# ✅ Module IAM

Ce module crée les rôles IAM nécessaires pour votre infrastructure :

- EC2 Runner
- K8s Nodes
- AWS Backup
- AWS Config

Chaque rôle a :
- une **policy d’assume-role**
- une **policy attachée (AWS Managed)**

## 🔧 Ressources créées

- `aws_iam_role.runner` + `aws_iam_instance_profile.runner`
- `aws_iam_role.k8s_nodes`
- `aws_iam_role.backup`
- `aws_iam_role.config`

## 📤 Outputs

| Output                      | Description                                           |
|-----------------------------|-------------------------------------------------------|
| iam_instance_profile_runner | Nom du profil EC2 pour l'instance runner             |
| iam_role_k8s_nodes          | ARN du rôle IAM pour les nœuds K8s                   |
| iam_role_backup             | ARN du rôle IAM pour AWS Backup                      |
| iam_role_config             | ARN du rôle IAM pour AWS Config                      |

## 📦 Exemple d'utilisation

```hcl
module "iam" {
  source = "./iam"
}
