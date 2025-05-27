terraform {
  backend "s3" {
    bucket = "my-tf-backend-sharepictures"
    key         = "./prod/terraform.tfstate"
    region      = "eu-west-1"
    encrypt     = true
    profile        = "mon-profil-pro"
  }
}