resource "kubernetes_secret" "db" {
  metadata {
    name      = "db-credentials"
    namespace = "illuminati"
  }

  data = {
    MARIADB_USER     = var.db-user
    MARIADB_PASSWORD = var.db-password
    MARIADB_HOST     = aws_db_instance.db-instance.address
    MARIADB_PORT     = var.db-port
    MARIADB_DATABASE = var.db-name
  }
  type = "Opaque"
}
