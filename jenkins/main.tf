module "ec2-jenkins" {
  source               = "../modules/jenkins"
  vpc_id               = data.aws_vpc.dev.id
  subnet_ids           = ["${data.aws_subnets.dev-private.ids[0]}"]
  iam_instance_profile = data.terraform_remote_state.common_iam.outputs.jenkins_role_name
  project_name_prefix  = local.workspace.account_name
  instance_type        = local.workspace.jenkins.instance_type
  root_volume_size     = local.workspace.jenkins.root_volume_size
  volume_type          = local.workspace.jenkins.volume_type
  ami_id               = local.workspace.jenkins.ami_id

  common_tags          = local.workspace.common_tags
  key_name             = local.workspace.key_name


}
