output "db-secret-name" {
  value = kubernetes_secret.db.metadata[0].name
}
