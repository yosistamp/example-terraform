variable "region" {
  default = "ap-northeast-1"
}

variable "ecs_service" {
  type = object({
    name = string
    desired_count = number
    health_check_grace_period_seconds = number
    launch_type = string
    force_new_deployment = bool
  })
  default = {
    name = "example-service"
    desired_count = 1
    health_check_grace_period_seconds = 30
    launch_type = "FARGATE"
    force_new_deployment = true
  }  
}

variable "remote_state_bucket" {
  description = "remote state bucket"
}