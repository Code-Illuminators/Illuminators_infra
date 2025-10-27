locals {
  set_ecr = {
    backend_ecr  = var.illuminators_backend_ecr
    frontend_ecr = var.illuminators_frontend_ecr
    service_ecr  = var.illuminators_service_ecr
  }
}

resource "aws_ecr_repository" "illuminators_ecr_set" {
  for_each             = local.set_ecr
  name                 = each.value
  image_tag_mutability = var.ecr_image_tag_mutability

  tags = {
    Name = each.value
  }
}
