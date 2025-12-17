resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public_external" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gateway.id
}

resource "aws_route_table_association" "public_subnets" {
  for_each = aws_subnet.public
  route_table_id = aws_route_table.public.id
  subnet_id = each.value.id
}