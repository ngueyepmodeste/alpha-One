data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical - Ubuntu

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
   provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt upgrade -y"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # ou "ec2-user" selon l'AMI
      private_key = file(var.bastion_private_key_path) # À définir en variable
      host        = self.private_ip
    }
  }
  tags = {
    Name = "bastion-host"
  }
}

