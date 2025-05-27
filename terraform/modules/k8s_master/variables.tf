variable "ami_id" {
  description = "AMI ID to use for the Kubernetes master node"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Kubernetes master node"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name to attach to the instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where to launch the master node (private subnet)"
  type        = string
}

variable "private_ip" {
  description = "Private IP to assign to the instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to associate"
  type        = list(string)
}
