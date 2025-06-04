include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/karpenter"
}

dependency "eks" {
  config_path = "../eks"
}

inputs = {
  cluster_name                       = dependency.eks.outputs.cluster_name
  cluster_endpoint                   = dependency.eks.outputs.cluster_endpoint
  cluster_certificate_authority_data = dependency.eks.outputs.cluster_certificate_authority_data
  service_account                    = dependency.eks.outputs.service_account
  queue_name                         = dependency.eks.outputs.queue_name
  node_iam_role_name                 = dependency.eks.outputs.node_iam_role_name
}
