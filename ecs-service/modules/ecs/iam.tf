resource "aws_iam_role" "default_ecs_execution" {
  name = "${var.name}-default-execution-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.name}-default-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "default_ecs_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.default_ecs_execution.name
}

resource "aws_iam_role" "default_ecs_task" {
  name = "${var.name}-default-task-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.name}-default-task-role"
  }
}

resource "aws_iam_policy" "default_ecs_task" {
  name = "${var.name}-default-task-policy"
  path = "/service-role/"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Effect": "Allow",
        "Resource": [
          "*"
        ]
      }
    ]
  })

  tags = {
    Name = "${var.name}-default-task-policy"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task" {
  policy_arn = aws_iam_policy.default_ecs_task.arn
  role       = aws_iam_role.default_ecs_task.name
}
