resource "aws_iam_role" "provisioner" {
  assume_role_policy = data.aws_iam_policy_document.provisoner_assume_role_policy.json
}

data "aws_iam_policy_document" "provisoner_assume_role_policy" {
  statement {
    # TODO: add statements
  }
}