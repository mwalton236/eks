resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone_name

  tags = {
    Name = "public_${each.key}"
    VPC  = var.vpc_name
  }
}

output "public_subnets" {
  value = aws_subnet.public
}