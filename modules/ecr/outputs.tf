output "repo_url_backend" {
  value = aws_ecr_repository.illuminators_backend_ecr.repository_url
}

output "repo_url_frontend" {
  value = aws_ecr_repository.illuminators_frontend_ecr.repository_url
}

output "repo_url_service" {
  value = aws_ecr_repository.illuminators_service_ecr.repository_url
}

