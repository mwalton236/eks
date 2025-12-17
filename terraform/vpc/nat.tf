resource "aws_eip" "nat" {
  for_each = toset(local.availability_zones)

  domain = "vpc"

  tags = {
    Name = "nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each = toset(local.availability_zones)

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "nat-${each.key}"
  }

  depends_on = [aws_internet_gateway.gateway]
}
