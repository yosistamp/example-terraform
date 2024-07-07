variable "terraform_bucket_name" {}

# dynamodb table name for terraform tfstate lock
# if you don't need to lock, set null.
variable "terraform_state_lock_table_name" {
  #default = null
  default = "terraform-tfstate-lock"
}
# aws region 
variable "region" {
  default = "ap-northeast-1"
}