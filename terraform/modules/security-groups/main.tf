locals {
  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# SG: Bastion
resource "aws_security_group" "bastion" {
  name        = "sg_bastion"
  description = "Security Group for Bastion Host"

  ingress {
    description      = "SSH access from allowed IPs"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.allowed_ssh_cidrs
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = merge(local.tags, { Name = "sg_bastion" })
}

# SG: K8s Master
resource "aws_security_group" "master" {
  name        = "sg_master"
  description = "Security Group for Kubernetes Master"
  
  ingress = [
    {
      from_port        = 10250
      to_port          = 10250
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Kubelet API"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 30000
      to_port          = 32767
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "NodePort services"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 6783
      to_port          = 6783
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Weave CNI"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 6783
      to_port          = 6783
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Weave CNI"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 8472
      to_port          = 8472
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Flannel VXLAN"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 51820
      to_port          = 51820
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Cilium WireGuard"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 9100
      to_port          = 9100
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Node Exporter"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 10254
      to_port          = 10254
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Ingress Controller checks"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all egress"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = merge(local.tags, { Name = "sg_master" })
}

# SG: K8s Worker
resource "aws_security_group" "worker" {
  for_each = var.vpc_id
  name        = "sg_worker"
  vpc_id      = each.value
  description = "Security Group for Kubernetes Workers"
  ingress = [
    {
      from_port        = 5432
      to_port          = 5432
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "PostgreSQL"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "MySQL"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTP ingress"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTPS ingress"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 9090
      to_port          = 9090
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Prometheus UI access"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 3000
      to_port          = 3000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Grafana UI access"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      from_port        = 9100
      to_port          = 9100
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Node Exporter for Prometheus"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Allow all egress"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = merge(local.tags, { Name = "sg_worker" })
}

# SG: ALB
resource "aws_security_group" "alb" {
  name        = "sg_alb"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id["vpc_b"] 
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = merge(local.tags, { Name = "sg_alb" })
}

# SG: GitLab Runner
resource "aws_security_group" "runner" {
  name        = "sg_runner"
  description = "Security Group for GitLab Runner"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.allowed_ssh_cidrs
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = merge(local.tags, { Name = "sg_runner" })
}

# SG: Vault
resource "aws_security_group" "vault" {
  for_each    = var.vpc_id
  name        = "sg_vault_${each.key}"
  description = "Security Group for Vault in ${each.key}"
  vpc_id      = each.value
  ingress {
    description      = "Vault HTTPS access"
    from_port        = 8200
    to_port          = 8200
    protocol         = "tcp"
    cidr_blocks      = var.allowed_internal_cidrs
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = merge(local.tags, { Name = "sg_vault" })
}
