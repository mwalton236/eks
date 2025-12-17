module "vpc" {
  source = "./vpc"
  region = var.region
}

module "eks" {
  source = "./eks"

  private_subnet_ids = values(module.vpc.private_subnets)[*].id
}

output "vpc" {
  value = module.vpc
}
