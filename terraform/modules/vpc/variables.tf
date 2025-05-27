variable "vpc_a_cidr" { default = "10.10.0.0/16" }
variable "public_subnet_a_cidr" { default = "10.10.1.0/24" }
variable "private_subnet_a_cidr" { default = "10.10.2.0/24" }

variable "vpc_b_cidr" { default = "192.168.0.0/16" }
variable "public_subnet_b_cidr" { default = "192.168.1.0/24" }
variable "private_subnet_b1_cidr" { default = "192.168.2.0/24" }
variable "private_subnet_b2_cidr" { default = "192.168.3.0/24" }

variable "az_a" { default = "us-east-1a" }
variable "az_b" { default = "us-east-1b" }
variable "az_c" { default = "us-east-1c" }
