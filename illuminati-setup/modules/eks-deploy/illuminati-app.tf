resource "helm_release" "frontend" {
  name             = "frontendchart"
  chart            = var.frontend-chart
  namespace        = "illuminati"
  create_namespace = true
  force_update     = true
  replace          = true
  set = [{
    name  = "hostedZoneName"
    value = var.domain-name
    },
    {
      name  = "image.repository"
      value = "${var.account-id}.dkr.ecr.${var.region}.amazonaws.com/illuminators_frontend_ecr"
  }]
}

resource "helm_release" "backend" {
  name             = "backendchart"
  chart            = var.backend-chart
  namespace        = "illuminati"
  create_namespace = false
  set = [{
    name  = "database.secretName"
    value = var.db-secret-name
    },
    {
      name  = "image.repository"
      value = "${var.account-id}.dkr.ecr.${var.region}.amazonaws.com/illuminators_backend_ecr"
  }]
}
