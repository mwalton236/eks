terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.17.0"
    }
  }
}
resource "aws_iam_role" "role" {
  name_prefix        = var.name_prefix
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {

  }
}

variable "name_prefix" {}

output "role_arn" {
  value = aws_iam_role.role.arn
}