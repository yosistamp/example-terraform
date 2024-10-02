module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name   = "${var.name}-alb-sg"
  vpc_id = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = var.vpc_cidr
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "${var.name}-alb-sg"
  }
}