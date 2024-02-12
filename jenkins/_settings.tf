terraform {
  backend "s3" {
    bucket  = "ais-poc-us-east-1-tothenew-backend"
    key     = "common/jenkins/main.tf"
    region  = "us-east-1"
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

    }
  }
}

locals {
  env_space = yamldecode(file("../config-${terraform.workspace}.yml"))
  workspace = local.env_space
}
