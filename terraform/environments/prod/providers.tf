terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.6.0"
}

# Provider par défaut
provider "aws" {
  profile = "mon-profil-pro"
  region  = "us-east-1"
}

# Provider avec alias pour certains modules
provider "aws" {
  alias   = "us_east_1"
  profile = "mon-profil-pro"
  region  = "us-east-1"
}
