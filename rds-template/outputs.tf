output "vpc_id" {
  value = module.vpc.vpc_id
}

output "lambda_private_subnet_ids" {
  value = module.vpc.lambda_private_subnet_ids
}

output "rds_private_subnet_ids" {
  value = module.vpc.rds_private_subnet_ids
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "db_proxy_endpoint" {
  value = module.rds.db_proxy_endpoint
}

output "db_name" {
  value = module.rds.db_name
}

output "db_secret_arn" {
  value = module.rds.db_secret_arn
}
