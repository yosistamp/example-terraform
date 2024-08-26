resource "aws_security_group" "example_app" {
  name        = "${var.name}-private-sg"
  description = "private alb security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "from private subnet"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  tags = {
    Name = "${var.name}-private-sg"
  }
}
