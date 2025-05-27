resource "aws_instance" "runner" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name

  tags = {
    Name = "gitlab-runner"
  }

  user_data = file("${path.module}/user_data.sh")
}