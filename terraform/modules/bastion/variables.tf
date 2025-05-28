variable "vpc_id" {}

variable "subnet_id" {
  description = "Subnet public du VPC A"
  type = string
}

variable "ami_id" {
  description = "AMI ID pour EC2 (Ubuntu/Amazon Linux)"
}

variable "instance_type" {
  default     = "t3.micro"
  description = "Type d'instance pour le bastion"
}

variable "key_name" {
  description = "Nom de la clé SSH"
}

variable "allowed_ssh_cidrs" {
  type        = list(string)
  description = "Liste des CIDRs autorisés à SSH (ex: ton IP publique)"
}
variable "sg_bastion" {
  description = "Security Group du Bastion"
  type = string
  
}
variable "bastion_private_key_path" {
  description = "Chemin vers la clé privée SSH pour accéder à l'instance"
  type        = string
}
