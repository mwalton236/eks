resource "aws_internet_gateway" "gateway" {}

resource "aws_internet_gateway_attachment" "attachment" {
  internet_gateway_id = aws_internet_gateway.gateway.id
  vpc_id              = aws_vpc.vpc.id
}
