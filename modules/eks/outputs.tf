output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output cluster_certificate_authority_data {
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output cluster_name {
  value       = module.eks.cluster_name
}

output service_account {
  value       = module.karpenter.service_account
}

output queue_name {
  value       = module.karpenter.queue_name
}

output node_iam_role_name {
  value       = module.karpenter.node_iam_role_name
}