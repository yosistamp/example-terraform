provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    region         = "ap-northeast-1"
    key            = "terraform-ecr.tfstate"
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

module "ecr" {
  source   = "./modules/ecr"
  for_each = { for v in var.repository : v.name => v }

  name           = each.value.name
  tag_mutability = each.value.tag_mutability
  scan_on_push   = each.value.scan_on_push
}
