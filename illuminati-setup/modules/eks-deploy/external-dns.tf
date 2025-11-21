data "aws_iam_policy_document" "external-dns-document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "external-dns-role" {
  name               = "${var.cluster-name}-external-dns"
  assume_role_policy = data.aws_iam_policy_document.external-dns-document.json
}

resource "aws_iam_policy" "external-dns-policy" {
  name = "${aws_iam_role.external-dns-role.name}-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResources"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones"
        ],
        "Resource" : [
          "*"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external-dns-policy-attachment" {
  role       = aws_iam_role.external-dns-role.name
  policy_arn = aws_iam_policy.external-dns-policy.arn
}

resource "aws_eks_pod_identity_association" "external-dns" {
  cluster_name    = "${var.cluster-name}-${var.env}"
  namespace       = "kube-system"
  service_account = "external-dns"
  role_arn        = aws_iam_role.external-dns-role.arn
}

resource "helm_release" "external-dns" {
  name         = "external-dns"
  chart        = var.external-dns-chart
  force_update = true
  replace      = true
}
