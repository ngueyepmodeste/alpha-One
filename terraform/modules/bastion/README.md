# 🛡️ Bastion Host Module

Ce module crée une instance EC2 dans un subnet public pour servir de Bastion (jump host) afin d'accéder de manière sécurisée aux ressources privées des VPC.

## 📌 Fonctionnalités

- Création d'une instance EC2 avec IP publique
- Association d'un Security Group restreint (SSH uniquement)
- Option de configuration via variables (AMI, type, clé SSH, etc.)
- Outputs utiles pour les connexions et automatisations

## 📥 Entrées (`variables.tf`)

| Variable              | Description                                      | Type         | Requis |
|-----------------------|--------------------------------------------------|--------------|--------|
| `vpc_id`              | ID du VPC dans lequel déployer l'instance        | `string`     | ✅      |
| `subnet_id`           | ID du subnet public (VPC A)                      | `string`     | ✅      |
| `ami_id`              | AMI ID (Ubuntu, Amazon Linux, etc.)             | `string`     | ✅      |
| `instance_type`       | Type d'instance EC2                              | `string`     | ✅      |
| `key_name`            | Nom de la clé SSH à utiliser                     | `string`     | ✅      |
| `allowed_ssh_cidrs`   | Liste des CIDRs autorisés à se connecter en SSH  | `list(string)`| ✅     |

## 📤 Sorties (`outputs.tf`)

| Output               | Description                      |
|----------------------|----------------------------------|
| `bastion_instance_id`| ID de l'instance EC2             |
| `bastion_public_ip`  | Adresse IP publique de l'instance|

## 🔐 Recommandations de sécurité

- Restreindre `allowed_ssh_cidrs` à votre IP uniquement.
- Éviter d'exposer d'autres ports que le SSH (22).
- Utiliser des outils comme `Session Manager` à la place du SSH si possible.

## 🗺️ Exemple d'utilisation

```hcl
module "bastion" {
  source            = "./modules/bastion"
  vpc_id            = module.vpc.vpc_a_id
  subnet_id         = module.vpc.vpc_a_public_subnet_id
  ami_id            = "ami-xxxxxxxx"
  instance_type     = "t3.micro"
  key_name          = "my-key"
  allowed_ssh_cidrs = ["xx.xx.xx.xx/32"]
}
