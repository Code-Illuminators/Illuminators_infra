resource "aws_ecr_repository" "ecr" {
  for_each             = var.set_ecr
  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

    tags = merge(
    var.common_tags,
    {
      Service = each.key
    }
  )
}
