resource "aws_ecr_repository" "repository" {
  name                 = var.name
  image_tag_mutability = var.tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}