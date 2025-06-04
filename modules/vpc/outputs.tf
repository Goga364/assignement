
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "intra_subnets" {
  value = module.vpc.intra_subnets
}

output "region" {
  value  = var.region
}

output "cluster_name" {
  value  = var.cluster_name
}

