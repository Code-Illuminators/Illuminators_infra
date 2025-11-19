provider "aws" {
  alias   = "stage_account"
  profile = "stage_account"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "dev_account"
  profile = "dev_account"
  region  = "us-east-1"
}

data "aws_caller_identity" "stage_account" {
  provider = aws.stage_account
}

# data "aws_iam_policy" "test_bucket_iam_policy" {
#   provider = aws.dev_account
#   name     = "AmazonS3FullAccess"
# }

data "aws_iam_policy_document" "terraform_deployment_role_dev_01" {
  provider = aws.dev_account
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:SetSourceIdentity"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.stage_account.account_id}:root"]
    }
  }
}

resource "aws_iam_role" "terraform_deployment_role_dev_01" {
  provider            = aws.dev_account
  name                = "terraform-deployment-role-dev-01"
  assume_role_policy  = data.aws_iam_policy_document.terraform_deployment_role_dev_01.json
  tags                = {}
}

resource "aws_iam_role_policy_attachment" "assume_role_attachment" {
  provider = aws.dev_account
  role       = aws_iam_role.terraform_deployment_role_dev_01.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}