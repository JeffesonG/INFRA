resource "aws_launch_configuration" "ecs_launch" {
  image_id      = var.ECSInstanceIMA
  instance_type = var.ECSInstanceType

}

resource "aws_autoscaling_group" "cluster" {

  name = format("%s-AutoScalingGroup", var.cluster_name)
  vpc_zone_identifier = [
    var.private_subnet_1a.id,
    var.private_subnet_1c.id
  ]
  launch_configuration = aws_launch_configuration.ecs_launch.name
  desired_capacity     = lookup(var.auto_scale_options, "desired")
  max_size             = lookup(var.auto_scale_options, "max")
  min_size             = lookup(var.auto_scale_options, "min")
  health_check_type    = "EC2"

  tag {
    key                 = "Nome"
    value               = var.cluster_name
    propagate_at_launch = true
  }

}