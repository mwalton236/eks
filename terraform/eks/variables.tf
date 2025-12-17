variable "cluster_name" {
  description = "name of the cluster"
  type        = string
  default     = "hive"
}

variable "private_subnet_ids" {
  description = "private subnet IDs"
  type        = list(string)
}
