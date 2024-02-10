resource "aws_eks_node_group" "on_demand" {
  count           = local.workspace.eks.on_demand.create ? 1 : 0
  cluster_name    = "${local.workspace.account_name}-${local.workspace.environment_name}-app"
  node_group_name = "${local.workspace.account_name}-${local.workspace.environment_name}-on-demand-group"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = data.aws_subnets.private.ids
  ami_type        = "AL2_ARM_64"
  capacity_type   = "ON_DEMAND"
  disk_size       = 50
  instance_types  = local.workspace.eks.instance_type
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  remote_access {
    ec2_ssh_key = local.workspace.key_name
  }
  scaling_config {
    desired_size = local.workspace.eks.on_demand.desired_size
    max_size     = local.workspace.eks.on_demand.min_size
    min_size     = local.workspace.eks.on_demand.max_size
  }
  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = "${local.workspace.account_name}-${local.workspace.environment_name}-app"
  }
  depends_on = [aws_eks_cluster.app]
}

resource "aws_eks_node_group" "spot" {
  count           = local.workspace.eks.spot.create ? 1 : 0
  cluster_name    = "${local.workspace.account_name}-${local.workspace.environment_name}-app"
  node_group_name = "${local.workspace.account_name}-${local.workspace.environment_name}-spot-group"
  node_role_arn   = aws_iam_role.eks_node_group.arn
  subnet_ids      = data.aws_subnets.private.ids
  ami_type        = "AL2_ARM_64"
  capacity_type   = "SPOT"
  disk_size       = local.workspace.eks.root_volume_size
  instance_types  = local.workspace.eks.instance_type
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  remote_access {
    ec2_ssh_key = local.workspace.key_name
  }
  scaling_config {
    desired_size = local.workspace.eks.spot.desired_size
    max_size     = local.workspace.eks.spot.min_size
    min_size     = local.workspace.eks.spot.max_size
  }
  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = "${local.workspace.account_name}-${local.workspace.environment_name}-app"
  }
  depends_on = [aws_eks_cluster.app]
}