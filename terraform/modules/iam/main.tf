resource "aws_iam_role" "runner" {
  name = "iam-role-runner"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_instance_profile" "runner" {
  name = "iam-instance-profile-runner"
  role = aws_iam_role.runner.name
}

resource "aws_iam_role" "k8s_nodes" {
  name = "iam-role-k8s-nodes"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role" "backup" {
  name = "iam-role-backup"
  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json
}

resource "aws_iam_role" "config" {
  name = "iam-role-config"
  assume_role_policy = data.aws_iam_policy_document.config_assume_role.json
}
