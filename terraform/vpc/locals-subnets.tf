# data "aws_availability_zones" "available" {
#   # state = "available"
# }

locals {
  public_cidr  = cidrsubnet(var.vpc_cidr_block, 2, 0)
  private_cidr = cidrsubnet(var.vpc_cidr_block, 2, 1)
  zones        = ["a", "b", "c"]
  public_subnets = {
    for i in range(length(local.zones)) : local.zones[i] => {
      cidr_block             = cidrsubnet(local.public_cidr, 8, i)
      availability_zone_name = format("%s%s", var.region, local.zones[i])
      # availability_zone_name = data.aws_availability_zones.available.names[i]
    }
  }

  private_subnets = {
    for i in range(length(local.zones)) : local.zones[i] => {
      cidr_block             = cidrsubnet(local.private_cidr, 8, i)
      availability_zone_name = format("%s%s", var.region, local.zones[i])
      # availability_zone_name = data.aws_availability_zones.available.names[i]
    }
  }
}