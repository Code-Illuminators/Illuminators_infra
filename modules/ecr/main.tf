resource "aws_ecr_repository" "illuminators_backend_ecr" {
  name                 = var.illuminators_backend_ecr
  image_tag_mutability = var.ecr_image_tag_mutability

  tags = {
    Name = "illuminators_ecr_repo"
  }
}

resource "aws_ecr_repository" "illuminators_frontend_ecr" {
  name                 = var.illuminators_frontend_ecr
  image_tag_mutability = var.ecr_image_tag_mutability

  tags = {
    Name = "illuminators_ecr_repo"
  }
}

resource "aws_ecr_repository" "illuminators_service_ecr" {
  name                 = var.illuminators_service_ecr
  image_tag_mutability = var.ecr_image_tag_mutability

  tags = {
    Name = "illuminators_ecr_repo"
  }
}