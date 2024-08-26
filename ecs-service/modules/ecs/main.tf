resource "aws_ecs_service" "example_app" {
  name                              = var.name
  cluster                           = var.cluster_id
  task_definition                   = aws_ecs_task_definition.example_app.arn
  desired_count                     = var.desired_count
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  launch_type                       = var.launch_type
  force_new_deployment              = var.force_new_deployment

  network_configuration {
    security_groups = [aws_security_group.example_app.id]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "demo-python"
    container_port   = 3000
  }

  tags = {
    Name = var.name
  }

  lifecycle {
    ignore_changes = [
      task_definition,
      desired_count,
    ]
  }
}

resource "aws_ecs_task_definition" "example_app" {
  family = "demo-python"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu       = 256
  memory    = 512
  container_definitions = jsonencode([
    {
      name      = "demo-python"
      image     = "service-first"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}
