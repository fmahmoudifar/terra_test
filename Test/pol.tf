data "aws_iam_policy_document" "test" {
  statement {
    sid       = "AllowStsGetCallerIdentity"
    effect    = "Allow"
    actions   = ["sts:GetCallerIdentity"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "test_policy" {
  name_prefix = "terra-test-"
  path        = "/"
  description = "Test policy created by Terraform (not attached to any principal)."
  policy      = data.aws_iam_policy_document.test.json

  tags = {
    ManagedBy = "Terraform"
    Project   = "terra_test"
    Purpose   = "test-policy"
  }
}

output "test_policy_arn" {
  value = aws_iam_policy.test_policy.arn
}

