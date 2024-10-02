resource "aws_vpc_endpoint" "interface" {
  for_each = toset(var.vpc_endpoint)
  vpc_id       = aws_vpc.main.id
  service_name = each.key
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids = [ aws_subnet.private[var.private_subnet[0].name].id ] # コストを下げるため１つだけ作成
  security_group_ids = [ aws_security_group.vpc_endpoint.id ]

}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type = "Gateway"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count           = length(aws_subnet.private)
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.private[count.index].id
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.ap-northeast-1.dynamodb"
  vpc_endpoint_type = "Gateway"
  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "dynamodb:*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY
}

resource "aws_vpc_endpoint_route_table_association" "private_dynamodb" {
  count           = length(aws_subnet.private)
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
  route_table_id  = aws_route_table.private[count.index].id
}
