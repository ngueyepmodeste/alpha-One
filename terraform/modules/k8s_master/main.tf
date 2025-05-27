resource "aws_instance" "k8s_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_group_ids

  tags = {
    Name = "k8s-master"
  }
}
