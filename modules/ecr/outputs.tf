output "repo_url_backend" {
  value = aws_ecr_repository.illuminators_ecr_set["backend_ecr"].repository_url
}

output "repo_url_frontend" {
  value = aws_ecr_repository.illuminators_ecr_set["frontend_ecr"].repository_url
}

output "repo_url_service" {
  value = aws_ecr_repository.illuminators_ecr_set["service_ecr"].repository_url
}

