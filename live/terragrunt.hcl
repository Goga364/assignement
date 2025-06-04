locals {
  region         = "eu-central-1"
  bucket_name    = "challenge-terraform-states-goga-dev-1234"
  dynamodb_table = "terraform-locks"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = local.bucket_name
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    dynamodb_table = local.dynamodb_table
    encrypt        = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
}
EOF
}

inputs = {
  region = local.region
}
