# runtime parameter
variable "project" {
  default = "rds-template"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "vpc" {
  description = "VPC設定"
  type = object({
    vpc_cidr = string
    public_subnet = list(object({
      name = string
      cidr = string
      az   = string
    }))
    lambda_private_subnet = list(object({
      name = string
      cidr = string
      az   = string
    }))
    rds_private_subnet = list(object({
      name = string
      cidr = string
      az   = string
    }))
  })
  default = {
    vpc_cidr = "192.168.0.0/16"
    public_subnet = [
      {
        name = "public1"
        cidr = "192.168.10.0/24",
        az   = "ap-northeast-1a"
      },
      {
        name = "public2"
        cidr = "192.168.11.0/24",
        az   = "ap-northeast-1c"
      }
    ]
    lambda_private_subnet = [
      {
        name = "lambda1"
        cidr = "192.168.1.0/24",
        az   = "ap-northeast-1a"
      },
      {
        name = "lambda2"
        cidr = "192.168.2.0/24",
        az   = "ap-northeast-1c"
      }

    ]
    rds_private_subnet = [
      {
        name = "rds1"
        cidr = "192.168.3.0/24",
        az   = "ap-northeast-1a"
      },
      {
        name = "rds2"
        cidr = "192.168.4.0/24",
        az   = "ap-northeast-1c"
      }
    ]
  }
}
