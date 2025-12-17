resource "aws_subnet" "private" {
  for_each = toset(local.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, index(local.availability_zones, each.key) + 10)
  availability_zone = each.key

  tags = {
    Name                              = "private_${each.key}"
    VPC                               = var.vpc_name
    "kubernetes.io/role/internal-elb" = 1
  }
}

output "private_subnets" {
  value = aws_subnet.private
}
