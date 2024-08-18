provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    key            = "terraform-oidc.tfstate"
    encrypt        = true
    dynamodb_table = "terraform-tfstate-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.57.0"
    }
  }
}

module "oidc" {
  source           = "./modules/oidc"
  github_org_name = var.github_org_name
}
