terraform {
  backend "s3" {
    bucket  = "terraform-test-ttn"
    key     = "common/jenkins/main.tf"
    region  = "us-east-2"
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
  env_space = yamldecode(file("../config.yml"))
  workspace = local.env_space
}
