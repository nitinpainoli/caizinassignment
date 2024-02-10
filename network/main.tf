module "network" {
  source                = "git::https://github.com/tothenew/terraform-aws-vpc.git?ref=v0.2.0"
  cidr_block            = local.workspace.vpc.cidr_block
  name                  = "${local.workspace.account_name}-${local.workspace.environment_name}"
  subnet                = local.workspace.vpc.subnet
  create_vpc_endpoint   = local.workspace.vpc.create_vpc_endpoint
  common_tags           = local.workspace.common_tags
}
