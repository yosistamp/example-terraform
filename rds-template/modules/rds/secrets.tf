resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db-credentials-${terraform.workspace}"
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "clusteradmin"
    password = random_password.db_password.result
  })
}

resource "random_password" "db_password" {
  length  = 16
  special = false
}

