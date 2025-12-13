resource "aws_vpc" "vpc" {
  tags = {
    Name = var.vpc_name
  }

  cidr_block = var.vpc_cidr_block
}

output "vpc" {
  value = aws_vpc.vpc
}