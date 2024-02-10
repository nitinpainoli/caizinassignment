resource "aws_eks_cluster" "app" {
  name     = "${local.workspace.account_name}-${local.workspace.environment_name}-app"
  role_arn = aws_iam_role.eks_assume_role.arn 
  version  = local.workspace.eks.version
  vpc_config {
    endpoint_private_access = local.workspace.eks.endpoint_private_access
    endpoint_public_access  = local.workspace.eks.endpoint_public_access
    subnet_ids              = data.aws_subnets.private.ids
  }
  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  tags = local.workspace.common_tags
}

data "tls_certificate" "app" {
  url = aws_eks_cluster.app.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "app" {
  url = aws_eks_cluster.app.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [data.tls_certificate.app.certificates[0].sha1_fingerprint]
}

resource "aws_ec2_tag" "public_sub" {
  for_each    = toset(data.aws_subnets.public.ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
} 
resource "aws_ec2_tag" "private_sub" {
  for_each    = toset(data.aws_subnets.private.ids)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
} 
