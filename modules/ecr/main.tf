resource "aws_ecr_repository" "illuminators_ecr_set" {
  for_each             = var.ecr_set
  name                 = "${var.project}_${each.value}_${var.env}"
  image_tag_mutability = "MUTABLE"
}
