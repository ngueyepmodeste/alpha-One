resource "aws_instance" "vault" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.vault.id]
  associate_public_ip_address = false

  tags = {
    Name = "${var.project_name}-vault"
  }
}

resource "aws_security_group" "vault" {
  name        = "${var.project_name}-vault-sg"
  description = "Security group for Vault"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-vault-sg"
  }
}
