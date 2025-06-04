include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  cluster_name     = "karpenter-eks-cluster"
}
