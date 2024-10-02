provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    key            = "terraform-alb.tfstate"
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

module "alb" {
  source     = "./modules/alb"
  name       = var.alb.name
  internal   = var.alb.internal
  vpc_id     = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_cidr   = data.terraform_remote_state.vpc.outputs.vpc_cidr
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  bucket_id  = module.s3.bucket_id
}

module "s3" {
  source          = "./modules/s3"
  log_bucket_name = var.log_bucket_name
}
data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.remote_state_bucket
    key    = "terraform-vpc.tfstate"
    region = "ap-northeast-1"
  }
}