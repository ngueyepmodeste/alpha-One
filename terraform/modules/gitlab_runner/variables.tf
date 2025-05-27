variable "ami_id" {
    type        = string
}
variable "instance_type" {
   type        = string 
}
variable "subnet_id" {
    type        = string
}
variable "security_group_id" {
    type        = string
}
variable "key_name" {  
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
variable "vpc_id" {
  type = string
  description = "vpc de mon runner gitlab qui est vpc A"
}
variable "instance_profile_name" {}