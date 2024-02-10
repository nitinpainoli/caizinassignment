data "aws_vpc" "selected" {
  filter {
    name   = "tag:Environment"
    values = [local.workspace.environment_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "tag:Scope"
    values = ["private"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Scope"
    values = ["public"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.app.version}/amazon-linux-2/recommended/release_version"
}

# data "terraform_remote_state" "common_iam" {
#   backend   = "s3"
#   workspace = "default"
#   config = {
#     bucket  = "etv-infra"
#     encrypt = true
#     key     = "common/iam/main.tf"
#     region  = "ap-south-1"
#   }
# }