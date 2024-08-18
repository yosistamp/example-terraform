resource "aws_security_group" "vpc_endpoint" {
  name        = "vpc-endpoint"
  description = "vpc-endpoint security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "from private subnet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [for subnet in var.lambda_private_subnet : subnet.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-endpoint"
  }
}
