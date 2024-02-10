
output "jenkins_role_name" {
  value = aws_iam_role.ec2_jenkins_role.name
}

output jenkins_instance_profile_arn {
  value  = aws_iam_instance_profile.ec2_jenkins_instance_profile.arn
}

output "jenkins_role_arn" {
  value = aws_iam_role.ec2_jenkins_role.arn
}


output "private_ip" {
  value = aws_instance.ec2.private_ip
}

output "id" {
  value = aws_instance.ec2.id
}

output "arn" {
  value = aws_instance.ec2.arn
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "jenkins_version" {
  value = var.jenkins_version
}