provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    key            = "terraform-ecs-service.tfstate"
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
  source      = "./modules/ecs"
  name = var.ecs_service.name
  cluster_id = data.terraform_remote_state.ecs.outputs.cluster_id
  desired_count = var.ecs_service.desired_count
  health_check_grace_period_seconds = var.ecs_service.health_check_grace_period_seconds
  launch_type = var.ecs_service.launch_type
  force_new_deployment = var.ecs_service.force_new_deployment
  target_group_arn = module.alb.target_group_arn
  private_subnet_ids    = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  private_subnet_cidrs  = data.terraform_remote_state.vpc.outputs.private_subnet_cidrs
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
}

module "alb" {
  source                = "./modules/alb"
  name          = var.ecs_service.name
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  private_subnet_ids    = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  private_subnet_cidrs  = data.terraform_remote_state.vpc.outputs.private_subnet_cidrs
  private_alb_arn =  data.terraform_remote_state.ecs.outputs.private_alb_arn
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
 
  config = {
    bucket = var.remote_state_bucket
    key    = "terraform-vpc.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "ecs" {
  backend = "s3"
 
  config = {
    bucket = var.remote_state_bucket
    key    = "terraform-ecs.tfstate"
    region = "ap-northeast-1"
  }
}