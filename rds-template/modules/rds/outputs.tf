output "db_instance_endpoint" {
  value = aws_db_instance.example_postgres.endpoint
}

output "db_proxy_endpoint" {
  value = aws_db_proxy.example_proxy.endpoint
}

output "db_name" {
  value = aws_db_instance.example_postgres.db_name
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
}
