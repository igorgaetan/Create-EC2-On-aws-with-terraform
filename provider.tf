terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-172030247215-eu-north-1-an"
    key            = "k3s-test/terraform.tfstate" # Chemin interne au bucket
    region         = "eu-north-1"                # Région du BUCKET
    encrypt        = true                        # Chiffre le state au repos
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "eu-west-3"
}

variable "ssh_public_key" {
  type        = string
  description = "Clé publique SSH passée via GitHub Secrets"
}