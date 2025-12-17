# data "aws_availability_zones" "available" {
#   # state = "available"
# }

locals {
  availability_zones = [
    for zone in var.azs:
          format("%s%s", var.region, zone)
  ]
}
