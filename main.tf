resource "aws_launch_template" "kubus_ha_launchtemplate" {
  name_prefix   = "kubus-ha-"
  image_id      = var.ami
  instance_type = "t3.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.kubus_ha_sg.id]
  }

    user_data = filebase64("userdata.sh")
    iam_instance_profile {
        name = aws_iam_instance_profile.kubus_ha_instance_profile.name
    }


}


resource "aws_autoscaling_group" "kubus_autoscaling_group" {
  desired_capacity    = 3
  max_size            = 6
  min_size            = 3
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id      = aws_launch_template.kubus_ha_launchtemplate.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "kubus-ha-instance"
    propagate_at_launch = true
  }
  target_group_arns = [aws_lb_target_group.kubus_lb_target_group.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300
 

}

resource "aws_autoscaling_attachment" "kubus_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.kubus_autoscaling_group.name
  lb_target_group_arn   = aws_lb_target_group.kubus_lb_target_group.arn
}