include {
  path = find_in_parent_folders()
}


terraform {
  source = "../../../modules/eks"
}

inputs = {
  vpc_id          = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  intra_subnets   = dependency.vpc.outputs.intra_subnets
  region          = dependency.vpc.outputs.region
  cluster_name    = dependency.vpc.outputs.cluster_name
}

dependency "vpc" {
  config_path = "../vpc"
}