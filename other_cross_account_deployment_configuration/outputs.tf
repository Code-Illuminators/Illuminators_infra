# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "role_arn" {
  value = aws_iam_role.terraform_deployment_role_dev_01.arn
}
