locals {
  cluster_role_policy_attachments = [
    "AmazonEKSClusterPolicy",
    "AmazonEKSServicePolicy",
  ]
}

resource "aws_iam_role" "eks_cluster" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "cluster_role_policy_attachment" {
  for_each   = toset(local.cluster_role_policy_attachments)
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
  role       = aws_iam_role.eks_cluster.name
}
