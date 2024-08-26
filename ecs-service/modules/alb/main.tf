resource "aws_lb_target_group" "app_blue" {
  name        = "${var.name}-app-tg-b"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  port        = 3000

  health_check {
    path = "/healthz"
  }

  tags = {
    "Name" = "${var.name}-app-tg-b"
  }
}

resource "aws_lb_target_group" "app_green" {
  name        = "${var.name}-app-tg-g"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  port        = 3000

  health_check {
    path = "/healthz"
  }

  tags = {
    "Name" = "${var.name}-app-tg-g"
  }
}

resource "aws_lb_listener" "app_blue" {
  load_balancer_arn = var.private_alb_arn
  port              = 8000
  protocol          = "HTTP"

  # ターゲットグループへ
  default_action {
    # ALBのリスナーからターゲットグループへforwardする
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_blue.arn
  }

  tags = {
    "Name" = "${var.name}-alb-listener-blue"
  }
}

resource "aws_lb_listener" "app_green" {
  load_balancer_arn = var.private_alb_arn
  port              = 18000
  protocol          = "HTTP"

  # ターゲットグループへ
  default_action {
    # ALBのリスナーからターゲットグループへforwardする
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_green.arn
  }

  tags = {
    "Name" = "${var.name}-alb-listener-green"
  }
}