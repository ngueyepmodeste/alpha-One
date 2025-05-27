variable "project_name" {
  description = "Nom du projet utilisé pour nommer les ressources"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC où déployer Vault"
  type        = string
}

variable "subnet_id" {
  description = "ID du subnet privé pour Vault"
  type        = string
}

variable "ami_id" {
  description = "AMI ID de l'instance Vault"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2 pour Vault"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Nom de la paire de clés SSH"
  type        = string
}

variable "ssh_user" {
  description = "Utilisateur SSH utilisé pour la connexion Ansible ou provision"
  type        = string
  default     = "ubuntu"
}

variable "private_key_path" {
  description = "Chemin vers la clé SSH privée"
  type        = string
}

variable "private_ip" {
  description = "IP privée à attribuer à l'instance Vault"
  type        = string
}

variable "allowed_ips" {
  description = "Liste des CIDR autorisés à accéder à Vault (port 8200)"
  type        = list(string)
}

variable "vault_s3_backend_bucket_arn" {
  description = "arn du bucket S3 existant utilisé comme backend Vault"
  type        = string
}

variable "vault_kms_key_arn" {
  description = "ARN de la clé KMS existante pour chiffrer les secrets Vault"
  type        = string
}
