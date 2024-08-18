output "vpc_id" {
  value = aws_vpc.main.id
}

output "lambda_private_subnet_ids" {
  value = [for subnet in aws_subnet.lambda_private : subnet.id]
}

output "rds_private_subnet_ids" {
  value = [for subnet in aws_subnet.rds_private : subnet.id]
}

output "vpc_endpoint_sg_id" {
  value = aws_security_group.vpc_endpoint.id
}