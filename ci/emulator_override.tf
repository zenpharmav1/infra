# CI ONLY — copied into envs/dev/ by .github/workflows/terraform-emulator.yaml.
# Points the state backend and the AWS provider at AWS Emulator (https://127.0.0.1:9297)
# running on the GitHub runner. No AWS account or secrets are used.

terraform {
  backend "s3" {
    bucket       = "zen-pharma-terraform-state-ahmed"
    key          = "envs/dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true

    endpoints = {
      s3  = "https://127.0.0.1:9297"
      sts = "https://127.0.0.1:9297"
    }
    use_path_style           = true
    shared_credentials_files = ["~/.aws/emulator/9297/emulator_credentials"]
    shared_config_files      = ["~/.aws/emulator/9297/config"]
    custom_ca_bundle         = "~/.aws/emulator/9297/ca.pem"
    skip_metadata_api_check  = true
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/emulator/9297/emulator_credentials"]
  shared_config_files      = ["~/.aws/emulator/9297/config"]
  custom_ca_bundle         = "~/.aws/emulator/9297/ca.pem"
  skip_metadata_api_check  = true
  s3_use_path_style        = true
}

# The emulator has no public /aws/service/eks/... SSM parameters; skip the AMI version lookup.
module "eks" {
  use_latest_ami_release_version = false
}

# The emulator offers PostgreSQL 17.2 only (real AWS default in the module stays 17.9).
module "rds" {
  engine_version = "17.2"
}
