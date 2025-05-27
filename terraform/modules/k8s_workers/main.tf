resource "aws_launch_template" "k8s_worker_lt" {
  name_prefix   = "k8s-worker-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.security_group_id]
    subnet_id                   = var.subnet_id
  }

  user_data = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
  resource_type = "instance"

  tags = {
    Name        = "k8s-worker"
    Environment = "prod"
    Role        = "worker-node"
  }
}
}

resource "aws_autoscaling_group" "k8s_workers_asg" {
  desired_capacity     = 1
  min_size             = 1
  max_size             = 2
  vpc_zone_identifier  = [var.subnet_id]
  target_group_arns    = [var.target_group_arn]
  health_check_type    = "EC2"
  launch_template {
    id      = aws_launch_template.k8s_worker_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "k8s-worker"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
