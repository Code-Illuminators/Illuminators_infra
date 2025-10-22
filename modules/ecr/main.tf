resource "aws_ecr_repository" "illuminators_ecr_set" {
  for_each             = var.set_ecr
  name                 = each.key
  image_tag_mutability = var.ecr_image_tag_mutability

  tags = {
    Name = each.value
  }
}
