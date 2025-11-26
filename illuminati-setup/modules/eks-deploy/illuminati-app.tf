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
    },
    {
      name  = "ingress.certificate-arn"
      value = aws_acm_certificate.frontend.arn
  }]
}

resource "kubernetes_secret" "backend-cred" {
  metadata {
    name      = "backend-credentials"
    namespace = "illuminati"
  }

  data = {
    DJANGO_SECRET_KEY      = var.django-secret-key
    VOTING_SERVICE_URL     = var.voting-service-url
    ALLOWED_HOSTS          = var.allowed-hosts
    INTERNAL_SERVICE_TOKEN = var.internal-service-token
  }
  type = "Opaque"
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
    },
    {
      name  = "appCred.secretName"
      value = kubernetes_secret.backend-cred.metadata[0].name
  }]
}

resource "kubernetes_secret" "sender-voting" {
  metadata {
    name      = "sender-voting-credentials"
    namespace = "illuminati"
  }

  data = {
    SMTP_HOST              = var.smtp-host
    SMTP_USER              = var.smtp-user
    SMTP_PASS              = var.smtp-pass
    INTERNAL_SERVICE_TOKEN = var.internal-service-token
    USERS_API_URL          = var.users-api-url
    PASSWORD_SET_URL       = var.password-url
  }
  type = "Opaque"
}

resource "helm_release" "sender" {
  name             = "senderchart"
  chart            = var.sender-chart
  namespace        = "illuminati"
  create_namespace = false
  set = [{
    name  = "serviceCred.secretName"
    value = kubernetes_secret.sender-voting.metadata[0].name
    },
    {
      name  = "image.repository"
      value = "${var.account-id}.dkr.ecr.${var.region}.amazonaws.com/illuminators_sender_ecr"
  }]
}

resource "helm_release" "voting" {
  name             = "votingchart"
  chart            = var.voting-chart
  namespace        = "illuminati"
  create_namespace = false
  set = [{
    name  = "serviceCred.secretName"
    value = kubernetes_secret.sender-voting.metadata[0].name
    },
    {
      name  = "image.repository"
      value = "${var.account-id}.dkr.ecr.${var.region}.amazonaws.com/illuminator_voting_ecr"
  }]
}

