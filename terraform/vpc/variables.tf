variable "region" {
  description = "aws region"
  type        = string
  default     = "eu-west-2"
}

variable "vpc_cidr_block" {
  description = "cidr block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "name of the VPC"
  type        = string
  default     = "dev-vpc"
}