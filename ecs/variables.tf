# runtime parameter
variable "cluster_name" {
  default = "example-cluster"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "remote_state_bucket" {
  description = "remote state bucket"
}