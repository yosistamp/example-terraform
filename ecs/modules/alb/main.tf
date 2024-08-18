resource "aws_lb" "private" {
  name               = "${var.cluster_name}-private"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.private_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "${var.cluster_name}-private"
  }
}
