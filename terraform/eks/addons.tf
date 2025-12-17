locals {
  enabled_eks_addons = [
    "coredns",
    "kube-proxy",
    "vpc-cni",
  ]
}

resource "aws_eks_addon" "addon" {
  for_each     = toset(local.enabled_eks_addons)
  cluster_name = aws_eks_cluster.eks.name
  addon_name   = each.key
}
