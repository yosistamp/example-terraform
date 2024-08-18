provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    key            = "terraform-vpc.tfstate"
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

module "vpc" {
  source                = "./modules/vpc"
  project               = var.project
  vpc_cidr              = var.vpc.vpc_cidr
  public_subnet         = var.vpc.public_subnet
  private_subnet = var.vpc.private_subnet
  vpc_endpoint    = var.vpc_endpoint
}
