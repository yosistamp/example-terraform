variable "region" {
  default = "ap-northeast-1"
}

variable "alb" {
  description = "VPC設定"
  type = object({
    name            = string
    internal        = bool
    log_bucket_name = string
  })
  default = {
    name            = "example-alb"
    internal        = true
    log_bucket_name = "example-alb"
  }
}

variable "log_bucket_name" {
  description = "log_bucket"
  default     = "yosistamp-demo"
}

variable "remote_state_bucket" {
  description = "remote state bucket"
}