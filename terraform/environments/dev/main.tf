# fichier temporaire : create-backend-bucket.tf

provider "aws" {
  profile = "mon-profil-pro"  # ou ton profil AWS
  region  = "eu-west-1" # à adapter
}

resource "aws_s3_bucket" "backend" {
  bucket = "my-tf-backend-sharepictures"
  force_destroy = true

  tags = {
    Name        = "Terraform Backend"
    Environment = "prod"
  }
}
