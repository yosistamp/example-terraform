resource "aws_security_group" "alb" {
  name        = "${var.cluster_name}-private-sg"
  description = "private alb security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "from private subnet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    from_port   = 8000
    to_port     = 8899
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  egress {
    from_port   = 18000
    to_port     = 18899
    protocol    = "tcp"
    cidr_blocks = var.private_subnet_cidrs
  }

  tags = {
    Name = "vpc-endpoint"
  }
}
