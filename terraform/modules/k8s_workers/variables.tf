variable "ami_id" {
  description = "AMI ID for worker nodes"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "security_group_id" {
  description = "Security group for worker nodes"
  type        = string
}

variable "subnet_id" {
  description = "Private subnet for worker EC2 nodes"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN from the ALB"
  type        = string
}

variable "user_data" {
  description = "User data script for worker node bootstrap"
  type        = string
  default     = ""
}
