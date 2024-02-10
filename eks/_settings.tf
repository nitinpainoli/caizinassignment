terraform {
  backend "s3" {
    bucket  = "BACKEND_BUCKET"
    key     = "infra/eks/main.tf"
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
      version = "5.34.0"
    }
  }
}


provider "kubernetes" {
  host                   = aws_eks_cluster.app.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.app.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "${local.workspace.account_name}-${local.workspace.environment_name}-app"]
  }
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.app.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.app.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", "${local.workspace.account_name}-${local.workspace.environment_name}-app"]
    }
  }
}


locals {
  env_space = yamldecode(file("../../config-${terraform.workspace}.yml"))
  workspace = local.env_space
  oidc_provider = trimprefix(aws_eks_cluster.app.identity[0].oidc[0].issuer, "https://")
}
