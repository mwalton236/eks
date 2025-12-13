resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone_name

  tags = {
    Name = "private_${each.key}"
    VPC  = var.vpc_name
  }
}

output "private_subnets" {
  value = aws_subnet.private
}