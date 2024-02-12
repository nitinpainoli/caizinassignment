data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}

resource "aws_security_group_rule" "allow_ssh_from_my_ip" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = [format("%s/%s", chomp(data.http.myip.response_body), 32)]
  security_group_id = aws_eks_cluster.app.vpc_config[0].cluster_security_group_id
  description       = "Ip whitelisting for installing add-on services through terraform."
}

resource "aws_security_group_rule" "allow_ssh_from_vpc_ip" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = [data.aws_vpc.selected.cidr_block]
  security_group_id = aws_eks_cluster.app.vpc_config[0].cluster_security_group_id
}

