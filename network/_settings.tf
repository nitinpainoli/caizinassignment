terraform {
  backend "s3" {
    bucket  = "BACKEND_BUCKET"
    key     = "network/main.tf"
    region  = "BACKEND_BUCKET_REGION"
    encrypt = true

  }
}

provider "aws" {
  region = local.workspace["aws"]["region"]
}

terraform {
  required_version = ">= 1.3.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "4.23.0"
    }
  }
}

locals {
  env_space = yamldecode(file("../config-${terraform.workspace}.yml"))
  workspace = local.env_space
}
