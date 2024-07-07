resource "aws_db_proxy" "example_proxy" {
  name                   = "example-proxy"
  debug_logging          = false
  engine_family          = "POSTGRESQL"
  idle_client_timeout    = 1800
  require_tls            = true
  role_arn               = aws_iam_role.rds_proxy_role.arn
  vpc_security_group_ids = [aws_security_group.rds_proxy.id]
  vpc_subnet_ids         = var.rds_private_subnet_ids

  auth {
    auth_scheme = "SECRETS"
    iam_auth    = "DISABLED"
    secret_arn  = aws_secretsmanager_secret.db_credentials.arn
  }
}

resource "aws_db_proxy_default_target_group" "example_tg" {
  db_proxy_name = aws_db_proxy.example_proxy.name

  connection_pool_config {
    max_connections_percent = 100
  }
}

resource "aws_db_proxy_target" "example" {
  db_instance_identifier = aws_db_instance.example_postgres.identifier
  db_proxy_name          = aws_db_proxy.example_proxy.name
  target_group_name      = aws_db_proxy_default_target_group.example_tg.name
}
