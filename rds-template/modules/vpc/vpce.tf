resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.ap-northeast-1.secretsmanager"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [ aws_subnet.lambda_private[var.lambda_private_subnet[0].name].id ]
  security_group_ids = [ aws_security_group.vpc_endpoint.id ]

}
