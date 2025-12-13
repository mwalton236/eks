resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "private_subnets" {
  for_each = aws_subnet.private
  route_table_id = aws_route_table.private.id
  subnet_id = each.value.id
}