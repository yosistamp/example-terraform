variable "region" {
  default = "ap-northeast-1"
}

variable "repository" {
  description = "ECRリポジトリ名"
  type = list(object({
    name           = string
    tag_mutability = string
    scan_on_push   = bool
  }))
  default = [{
    name           = "user-api"
    tag_mutability = "MUTABLE"
    scan_on_push   = false
  }]
}
