module "vpc" {
  source = "./vpc"
  region = var.region
}

output "vpc" {
  value = module.vpc
}
