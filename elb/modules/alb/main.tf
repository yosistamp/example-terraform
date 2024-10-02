resource "aws_lb" "alb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [module.alb_security_group.security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  access_logs {
    bucket  = var.bucket_id
    prefix  = var.name
    enabled = true
  }

  tags = {
    Name        = var.name
    Environment = "production"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Temporary response"
      status_code  = "200"
    }
  }
}

