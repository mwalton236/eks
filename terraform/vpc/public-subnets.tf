resource "aws_subnet" "public" {
  for_each = toset(local.availability_zones)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, index(local.availability_zones, each.key))
  availability_zone = each.key

  tags = {
    Name                     = "public_${each.key}"
    VPC                      = var.vpc_name
    "kubernetes.io/role/elb" = 1
  }
}

output "public_subnets" {
  value = aws_subnet.public
}
