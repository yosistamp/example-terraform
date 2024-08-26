# runtime parameter
variable "project" {
  default = "vpc-template"
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
    private_subnet = list(object({
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
    private_subnet = [
      {
        name = "private1"
        cidr = "192.168.1.0/24",
        az   = "ap-northeast-1a"
      },
      {
        name = "private2"
        cidr = "192.168.2.0/24",
        az   = "ap-northeast-1c"
      }

    ]
  }
}

variable "vpc_endpoint" {
  description = "VPCエンドポイント設定"
  default = [
    "com.amazonaws.ap-northeast-1.ecr.dkr",
    "com.amazonaws.ap-northeast-1.ecr.api",
    "com.amazonaws.ap-northeast-1.logs",
    "com.amazonaws.ap-northeast-1.ecr.xray"
  ]
}

# 必要に応じて追加 
# com.amazonaws.ap-northeast-1.ssm
# com.amazonaws.ap-northeast-1.secretsmanager
