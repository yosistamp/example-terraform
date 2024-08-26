provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    key            = "terraform-ecs.tfstate"
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

module "ecs" {
  source                = "./modules/ecs"
  cluster_name          = var.cluster_name
}

module "alb" {
  source                = "./modules/alb"
  cluster_name          = var.cluster_name
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids    = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  private_subnet_cidrs  = data.terraform_remote_state.vpc.outputs.private_subnet_cidrs
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
 
  config = {
    bucket = var.remote_state_bucket
    key    = "terraform-vpc.tfstate"
    region = "ap-northeast-1"
  }
}