resource "aws_iam_user" "team" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

resource "aws_iam_group" "Administrator" {
  name = "Administrator"
}

resource "aws_iam_group_policy_attachment" "admin-policy" {
  group      = aws_iam_group.Administrator.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "admin-membership" {
  name  = "admin-membership"
  users = aws_iam_user.team[*].name
  group = aws_iam_group.Administrator.name
}

resource "aws_iam_user_login_profile" "password-user" {
  count                   = length(var.username)
  user                    = aws_iam_user.team[count.index].name
  password_reset_required = true
}

resource "aws_iam_access_key" "access-key" {
  count = length(var.username)
  user  = aws_iam_user.team[count.index].name
}

# data "aws_caller_identity" "stage_account" {
#   provider = aws.stage_account
# } //uncomment it when creates dev/prod acc after stage

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "terraform_deployment_role_dev_01" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:SetSourceIdentity"
    ]
    principals {
      type = "AWS"
      identifiers = concat(
        # ["arn:aws:iam::${data.aws_caller_identity.stage_account.account_id}:role/jenkins-role-stage-01"],
        [for user in aws_iam_user.team :
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${user.name}"]
      )
    }
  }
}

resource "aws_iam_role" "terraform_deployment_role_dev_01" {
  name               = "terraform-deployment-role-${var.env}"
  assume_role_policy = data.aws_iam_policy_document.terraform_deployment_role_dev_01.json
  tags               = {}
}

resource "aws_iam_role_policy" "terraform_deployment_role_dev_01_policy" {
  name   = "terraform_deployment_role_${var.env}_policy"
  role   = aws_iam_role.terraform_deployment_role_dev_01.id
  policy = file("./modules/iam/terraform-deployment-policy.json")
}
